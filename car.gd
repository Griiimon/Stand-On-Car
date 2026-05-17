class_name Car
extends RigidBody3D

const PLAYER_BASE_MODEL_SCENE = preload("res://player_base_model.tscn")
const PLAYER_BODY_MODEL_SCENE = preload("res://player_body_model.tscn")

@export var player: Player

@onready var player_offset: Marker3D = $PlayerOffset
@onready var pull_offset: Marker3D = $PullOffset


var last_position: Vector3
var last_velocity: Vector3
var acceleration: Vector3

var player_base_model: Node3D
var player_body_model: Node3D


func _ready() -> void:
	last_position = global_position
	last_velocity = Vector3.ZERO

	# Add the player model to the car
	player_base_model = PLAYER_BASE_MODEL_SCENE.instantiate()
	player_body_model = PLAYER_BODY_MODEL_SCENE.instantiate()
	add_child(player_base_model)
	add_child(player_body_model)


func _physics_process(delta: float) -> void:
	# TODO do we need the local velocity at the players position instead?
	var local_velocity := global_transform.affine_inverse() * linear_velocity
	acceleration = (local_velocity - last_velocity) / delta
	
	last_position = global_position
	last_velocity = local_velocity

	update_player_position()


# Render the player on top of the car according to the local offset and the transforms
# of the player in the separate physics space
func update_player_position():
	player_base_model.transform = player.base_model.global_transform.translated(player_offset.position)
	player_body_model.transform = player.body_model.global_transform.translated(player_offset.position)


# Pull the Rigidbody towards a point ahead to make it "drive"
func pull_towards(target_position: Vector3):
	target_position.y = pull_offset.global_position.y
	var force := target_position - pull_offset.global_position
	force = force.normalized() * force.length_squared()
	apply_force(force, pull_offset.global_position - global_position)
