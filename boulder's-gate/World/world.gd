extends Node2D

@export var enemy : PackedScene



func inst(scene):
	var instance = scene.instantiate()
	instance.global_position = Vector2(randi_range(40, 1112), randi_range(40, 608))
	instance.player = get_node("%Player")
	add_child(instance)
