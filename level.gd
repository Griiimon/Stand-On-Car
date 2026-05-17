extends Node3D

@export var player: Player
@export var car: Car

@export var car_speed: float = 10.0
@export var player_acceleration_factor: float = 0.01

@onready var path_follow: PathFollow3D = $Path3D/PathFollow3D


func _physics_process(delta: float) -> void:
	player.push(-car.acceleration * player_acceleration_factor)

	path_follow.progress += car_speed * delta
