extends CharacterBody2D

enum States {ROLLING, AIMING}

var state : States = States.ROLLING: set = set_state
var speed := 300

func set_state(new_state):
	state = new_state

func _ready() -> void:
	velocity = Vector2.UP.rotated(deg_to_rad(45)) * speed

func _physics_process(delta: float) -> void:
	rotation = velocity.angle()
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		print(velocity)
		velocity = velocity.bounce(collision.get_normal())
		print(velocity)
		#var reflect = collision.get_remainder().bounce(collision.get_normal())
		#velocity = velocity.bounce(collision.get_normal())
		#move_and_collide(reflect)
