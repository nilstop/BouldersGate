extends Node2D

@export var anim_player: AnimationPlayer
@export var sprite: Sprite2D

func _physics_process(_delta: float) -> void:
	var area: Area2D = get_parent().hit_area
	var collision = area.get_overlapping_bodies()
	if collision:
		var body = collision[0]
		if body.state != body.States.AIMING and body.current_velocity >= 150:
			die(body)

func die(body: CharacterBody2D = null):
	process_mode = Node.PROCESS_MODE_DISABLED
	sprite.self_modulate = Color.WHITE
	sprite.modulate.v = 15.0
	if body:
		body.impact()
	var parent : CharacterBody2D = get_parent()
	parent.collision_layer = 0
	await get_tree().create_timer(0.06).timeout
	anim_player.play("die")
