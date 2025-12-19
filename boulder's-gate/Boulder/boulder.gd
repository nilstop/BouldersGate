extends CharacterBody2D

@export var player : CharacterBody2D
@export var speed := 300

enum States {ROLLING, AIMING}

var state : States = States.ROLLING: set = set_state
var player_distance : int

func set_state(new_state):
	if new_state == States.AIMING:
		velocity = Vector2.ZERO
	if new_state == States.ROLLING:
		velocity = Vector2.RIGHT.rotated(rotation) * speed
	state = new_state

func _ready() -> void:
	velocity = Vector2.UP.rotated(deg_to_rad(45)) * speed



func _physics_process(delta: float) -> void:
	if !(is_on_floor() or is_on_wall() or is_on_ceiling()):
		if state == States.AIMING:
			pass#player.global_position = global_position + Vector2.UP.rotated(rotation) * player_distance
	if state == States.ROLLING:
		rotation = velocity.angle()
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision and state == States.ROLLING:
		print(velocity)
		velocity = velocity.bounce(collision.get_normal())
		print(velocity)
