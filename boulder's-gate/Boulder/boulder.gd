extends CharacterBody2D

@export var player : CharacterBody2D
@export var speed := 300.0
@export var vel_damping : float


enum States {ROLLING, AIMING}

var current_velocity := speed
var state : States = States.ROLLING: set = set_state
var player_distance : int
var speed_multiplier := 1.0: set = set_sm

func set_state(new_state):
	if new_state == States.AIMING:
		velocity = Vector2.ZERO
	if new_state == States.ROLLING:
		current_velocity = speed
		velocity = Vector2.RIGHT.rotated(rotation) * current_velocity * speed_multiplier
	state = new_state

func _ready() -> void:
	velocity = Vector2.UP.rotated(deg_to_rad(45)) * speed
	player.connect("hit", slow_down)

func slow_down():
	var tween = create_tween()
	tween.tween_method(set_sm, 0.0, 1.0, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)


func set_sm(new_sm):
	speed_multiplier = new_sm
	velocity = Vector2.RIGHT.rotated(rotation) * current_velocity * speed_multiplier

func impact():
	print("impactd")
	if velocity:
		var saved_velocity = velocity
		velocity = Vector2.ZERO
		await get_tree().create_timer(0.05).timeout
		velocity = saved_velocity

func _physics_process(delta: float):
	if state == States.ROLLING:
		rotation = velocity.angle()

	var remaining := delta
	var max_steps := 5

	while remaining > 0 and max_steps > 0:
		var collision := move_and_collide(velocity * remaining)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			velocity *= vel_damping
			current_velocity = velocity.length()

			var hit := collision.get_collider()
			if hit and hit.has_method("take_damage"):
				hit.take_damage()

			# Move the leftover time after collision
			remaining *= 0.5
			max_steps -= 1
		else:
			break
