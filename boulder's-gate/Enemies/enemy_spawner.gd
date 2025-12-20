extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene

var positions : Array = [Rect2(500.0,-100.0,180.0,0.0), Rect2(500.0,750.0,180.0,0), Rect2(-100,250,0.0,180.0), Rect2(1250,250,0.0,180.0)]

func inst(scene):
	var instance = scene.instantiate()
	var rect : Rect2 = positions[randi_range(0,3)]
	instance.global_position = Vector2(randi_range(rect.position.x, rect.position.x+rect.size.x), randi_range(rect.position.y, rect.position.y+rect.size.y))
	instance.player = get_node("%Player")
	add_child(instance)
	

func _on_mini_waves_timeout() -> void:
	for i in 3:
		inst(enemy)
