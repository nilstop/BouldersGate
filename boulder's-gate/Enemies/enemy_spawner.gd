extends Node2D

@export var player : CharacterBody2D
@export var basic_enemy : PackedScene
@export var large_enemy : PackedScene

var positions : Array = [Rect2i(500,-100,180,0), Rect2i(500,750,180,0), Rect2i(-100,250,0,180), Rect2i(1250,250,0,180)]

func inst(scene):
	var instance = scene.instantiate()
	var rect : Rect2i = positions[randi_range(0,3)]
	instance.global_position = Vector2(randi_range(rect.position.x, rect.position.x+rect.size.x), randi_range(rect.position.y, rect.position.y+rect.size.y))
	instance.player = get_node("%Player")
	add_child(instance)

func _on_mini_waves_timeout() -> void:
	for i in 3:
		inst(basic_enemy)
	if randi_range(0,3) == 0:
		inst(large_enemy)
