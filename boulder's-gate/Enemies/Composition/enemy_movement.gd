extends Node2D

@export var speed : int

var speed_multiplier := 1.0: set = set_sm

func set_sm(new_sm):
	speed_multiplier = new_sm

func _ready() -> void:
	get_parent().player.connect("hit", slow_down)

func _physics_process(delta: float) -> void:
	if Global.p_invisible:
		get_parent().set_collision_mask_value(3, false)
	else:
		get_parent().set_collision_mask_value(3, true)
	get_parent().velocity = Vector2.RIGHT.rotated(get_parent().rotation) * speed * speed_multiplier
	get_parent().move_and_collide(get_parent().velocity * delta)

func slow_down():
	var tween = create_tween()
	tween.tween_method(set_sm, 0.0, 1.0, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
