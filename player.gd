class_name Player
extends Node3D

@export var move_force: float = 100.0
@export var car: Car

@onready var base: RigidBody3D = $Base
@onready var body: RigidBody3D = $Body

@onready var base_model: MeshInstance3D = $Base/BaseModel
@onready var body_model: MeshInstance3D = $Body/BodyModel

@onready var level: Level


func _ready() -> void:
	level = get_tree().current_scene


func _physics_process(_delta: float) -> void:
	var move_vec2 := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_vec3 := Vector3(move_vec2.x, 0.0, move_vec2.y)
	
	# Push the base around when moving the player via inputs
	base.apply_central_force(move_vec3 * move_force)
	
	if not is_in_main_physics_space():
		# Calculate the players global transform in the main space
		var global_player_trans := car.player_offset.global_transform * base.transform
		
		# Build a shape cast query down from the base
		var query := PhysicsShapeQueryParameters3D.new()
		query.transform = global_player_trans.translated(Vector3.UP * 0.1)
		query.motion = Vector3.DOWN
		query.shape_rid = (base.get_child(0) as CollisionShape3D).shape.get_rid()
		
		# The the shape cast result in the main space
		var cast_result := level.get_world_3d().direct_space_state.cast_motion(query)
		
		# If it doesn't hit anything leave the car
		if cast_result[0] == 1.0 and cast_result[1] == 1.0:
			transfer_to_main_physics_space()


# Push against the upper part of the player when receiving forces
func push(force: Vector3):
	body.apply_central_force(force)


func transfer_to_main_physics_space():
	reparent(level.main_physics_space, false)
	position += car.player_offset.global_position
	car.hide_player_model()


func transfer_to_second_physics_space():
	assert(false)


func is_in_main_physics_space()-> bool:
	return get_parent() == level.main_physics_space


func _on_base_body_entered(body: Node) -> void:
	if body is Car and is_in_main_physics_space():
		transfer_to_second_physics_space()
