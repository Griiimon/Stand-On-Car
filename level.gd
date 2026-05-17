extends Node3D

@export var car_speed: float = 10.0

@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D


func _physics_process(delta: float) -> void:
	path_follow.progress += car_speed * delta
