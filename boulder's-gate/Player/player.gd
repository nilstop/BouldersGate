extends CharacterBody2D

signal hit

@onready var boulder_area: Area2D = $PickupArea
@onready var invis_frames: Timer = $InvisFrames
@onready var flash_timer: Timer = $FlashTimer
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

@export var boulder : CharacterBody2D
@export var speed : int
@export var rotation_speed : float
@export var boulder_distance : int
#@export var accel : int 

enum States {AIMING, WALKING}

var state : States = States.WALKING: set = set_state

var texture_regions: Array[Rect2i] = [Rect2i(0,0,32,18), Rect2i(32,0,18,24)]

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

func _process(_adelta: float) -> void:
	if state == States.WALKING:
		rotation = lerp_angle(rotation, global_position.angle_to_point(get_global_mouse_position()), 0.2)
	

func _physics_process(delta: float) -> void:
	if state == States.AIMING:
		rotate_toward_mouse_slowly(delta)
		boulder.move_and_collide(global_position + Vector2.RIGHT.rotated(rotation) * boulder_distance - boulder.global_position)
		boulder.rotation = rotation
	get_input()
	move_and_collide(velocity * delta)
	if Input.is_action_pressed("pick"):
		sprite.region_rect = texture_regions[1]
		sprite.offset = Vector2(0,-3)
		if boulder_area.has_overlapping_bodies():
			pick_up_boulder()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("pick"):
		sprite.offset = Vector2.ZERO
		sprite.region_rect = texture_regions[0]
		if state == States.AIMING:
			throw_boulder()

func pick_up_boulder():
	set_state(States.AIMING)
	boulder.set_state(boulder.States.AIMING)
	boulder.player_distance = boulder_distance

func throw_boulder():
	sprite.region_rect = texture_regions[0]
	set_state(States.WALKING)
	boulder.set_state(boulder.States.ROLLING)

#enemy hits you
func _on_enemey_area_body_entered(body: Node2D) -> void:
		if !Global.p_invisible:
			lose_health(body)

func _on_invis_frames_timeout() -> void:
	Global.p_invisible = false
	collision_shape.disabled = false
	flash_timer.stop()
	sprite.visible = true

func _on_flash_timer_timeout() -> void:
	sprite.visible = !sprite.visible

func lose_health(body):
	sprite.visible = !sprite.visible
	flash_timer.start()
	invis_frames.start()
	emit_signal("hit")
	Global.p_invisible = true
	Global.p_health -= 1
	if body.is_in_group("enemy"):
		body.die()

func _on_boulder_hit_area_body_entered(body: Node2D) -> void:
	if !Global.p_invisible and state != States.AIMING:
		lose_health(body)
