extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var boulder_area: Area2D = $BoulderArea


@export var speed : int

var speed_multiplier := 1.0: set = set_sm

func set_sm(new_sm):
	speed_multiplier = new_sm

func _ready() -> void:
	player.connect("hit", slow_down)

func _physics_process(_delta: float) -> void:
	#if Global.p_invisible == true:
	#	speed_multiplier = 0.3
	#else:
	#	speed_multiplier = 1.0
	velocity = Vector2.RIGHT.rotated(rotation) * speed * speed_multiplier
	move_and_slide()
	check_boulder_collision()

func _process(_delta: float) -> void:
	look_at(player.global_position)

func die():
	queue_free()

func slow_down():
	var tween = create_tween()
	tween.tween_method(set_sm, 0.0, 1.0, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)



func check_boulder_collision():
	if boulder_area.has_overlapping_bodies():
		var body = boulder_area.get_overlapping_bodies()[0]
		if body.state == body.States.ROLLING:
			die()
