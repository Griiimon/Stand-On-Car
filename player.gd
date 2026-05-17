class_name Player
extends Node3D

@export var move_force: float = 100.0

@onready var base: RigidBody3D = $Base
@onready var body: RigidBody3D = $Body

@onready var base_model: MeshInstance3D = $Base/BaseModel
@onready var body_model: MeshInstance3D = $Body/BodyModel


func _physics_process(_delta: float) -> void:
	var move_vec2 := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_vec3 := Vector3(move_vec2.x, 0.0, move_vec2.y)
	
	# Push the base around when moving the player via inputs
	base.apply_central_force(move_vec3 * move_force)


# Push against the upper part of the player when receiving forces
func push(force: Vector3):
	body.apply_central_force(force)
