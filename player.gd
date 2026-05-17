extends Node3D

@export var move_force: float = 100.0
@onready var base: RigidBody3D = $Base


func _physics_process(_delta: float) -> void:
	var move_vec2 := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var move_vec3 := Vector3(move_vec2.x, 0.0, move_vec2.y)
	
	base.apply_central_force(move_vec3 * move_force)
