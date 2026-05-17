class_name Car
extends CharacterBody3D

const PLAYER_BASE_MODEL_SCENE = preload("res://player_base_model.tscn")
const PLAYER_BODY_MODEL_SCENE = preload("res://player_body_model.tscn")

@export var player: Player

@onready var player_offset: Marker3D = $PlayerOffset


var last_position: Vector3
var last_velocity: Vector3
var acceleration: Vector3

var player_base_model: Node3D
var player_body_model: Node3D


func _ready() -> void:
	last_position = global_position
	last_velocity = Vector3.ZERO

	player_base_model = PLAYER_BASE_MODEL_SCENE.instantiate()
	player_body_model = PLAYER_BODY_MODEL_SCENE.instantiate()
	
	add_child(player_base_model)
	add_child(player_body_model)


func _physics_process(delta: float) -> void:
	var current_velocity := (global_position - last_position) / delta
	var local_velocity := current_velocity.rotated(Vector3.UP, rotation.y)
	acceleration = local_velocity / delta
	
	last_position = global_position
	last_velocity = current_velocity

	update_player_position()


func update_player_position():
	player_base_model.transform = player.base_model.global_transform.translated(player_offset.position)
	player_body_model.transform = player.body_model.global_transform.translated(player_offset.position)
	
