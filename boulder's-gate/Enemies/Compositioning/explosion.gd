extends Node2D

@export var taking_damage_node: Node2D
@export var explosion: PackedScene

func _ready() -> void:
	taking_damage_node.connect("death", explode)

func explode():
	print("explode")
	inst(explosion)

func inst(scene: PackedScene):
	print("inst")
	var instance = scene.instantiate()
	instance.scale = Vector2(2.5,2.5)
	add_sibling(instance)
