extends CharacterBody3D

@onready var path_follow: PathFollow3D = $".."

var last_position: Vector3
var last_velocity: Vector3
var acceleration: Vector3


func _ready() -> void:
	last_position = global_position
	last_velocity = Vector3.ZERO


func _physics_process(delta: float) -> void:
	var current_velocity := (global_position - last_position) / delta
	current_velocity.y = 0
	acceleration = ((current_velocity - last_velocity) / delta) * global_transform
	
	prints("Position", global_position)
	prints("Velocity", current_velocity)
	prints("Acceleration", acceleration)
	
	last_position = global_position
	last_velocity = current_velocity
