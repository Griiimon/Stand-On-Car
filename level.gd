extends Node3D

@export var player: Player
@export var car: Car
@export var path_follow: PathFollow3D

@export var car_speed: float = 10.0
@export var player_acceleration_factor: float = 0.01


func _physics_process(delta: float) -> void:
	# Transfer inverse car acceleration forces to the player in the seperate physics space
	player.push(-car.acceleration * player_acceleration_factor)
	
	if path_follow:
		# Advance and pull the car along the path
		path_follow.progress += car_speed * delta
		car.pull_towards(path_follow.global_position)
