extends CharacterBody2D

@onready var boulder_area: Area2D = $BoulderArea

@export var boulder : CharacterBody2D
@export var speed : int
@export var rotation_speed : float
@export var boulder_distance : int
#@export var accel : int 

enum States {AIMING, WALKING}

var state : States = States.WALKING: set = set_state

func set_state(new_state):
	state = new_state

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func rotate_toward_mouse_slowly(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = mouse_pos - global_position
	var target_angle = direction.angle()

	rotation = rotate_toward(rotation, target_angle, rotation_speed * delta)

func _process(delta: float) -> void:
	if state == States.WALKING:
		rotation = lerp_angle(rotation, global_position.angle_to_point(get_global_mouse_position()), 0.3)


func _physics_process(delta: float) -> void:
	if state == States.AIMING:
		rotate_toward_mouse_slowly(delta)
		boulder.move_and_collide(global_position + Vector2.RIGHT.rotated(rotation) * boulder_distance - boulder.global_position)
		boulder.rotation = rotation
	get_input()
	move_and_slide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("pick"):
		if boulder_area.has_overlapping_bodies():
			pick_up_boulder()
	if Input.is_action_just_released("pick"):
			if state == States.AIMING:
				throw_boulder()

func pick_up_boulder():
	set_state(States.AIMING)
	boulder.set_state(boulder.States.AIMING)
	boulder.player_distance = boulder_distance

func throw_boulder():
	set_state(States.WALKING)
	boulder.set_state(boulder.States.ROLLING)
