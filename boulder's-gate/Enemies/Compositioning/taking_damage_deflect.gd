extends Node2D

@export var death_fx: Deathfx
@export var max_health : int

var health : int

func _ready() -> void:
	health = max_health

func die():
	death_fx.die()

func take_damage():
	health -= 1
	if health <= 0:
		die()
