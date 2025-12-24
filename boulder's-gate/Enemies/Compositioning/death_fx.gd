extends Node2D
class_name Deathfx

@export var sprite: Sprite2D
@export var anim_player: AnimationPlayer
@export var death_fx_sprite: Sprite2D

func flash():
	sprite.self_modulate = Color.WHITE
	sprite.modulate.v = 15.0
	await get_tree().create_timer(0.05).timeout
	sprite.self_modulate = Color.WEB_GREEN
	sprite.modulate.v = 1.0

func die(body: CharacterBody2D = null):
	process_mode = Node.PROCESS_MODE_DISABLED
	sprite.self_modulate = Color.WHITE
	sprite.modulate.v = 15.0
	var parent: CharacterBody2D = get_parent()
	parent.collision_layer = 0
	parent.collision_mask = 0
	if body:
		body.impact(0.03)
	await get_tree().create_timer(0.03).timeout
	anim_player.play("die")
