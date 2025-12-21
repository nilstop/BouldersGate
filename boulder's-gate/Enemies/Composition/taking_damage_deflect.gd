extends Node2D

@export var max_health : int

var health : int

func _ready() -> void:
	health = max_health

func die():
	get_parent().queue_free()

func take_damage():
	health -= 1
	print(health)
	if health <= 0:
		print("die")
		die()
