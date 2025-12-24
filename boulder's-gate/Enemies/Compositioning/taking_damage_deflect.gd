extends Node2D
signal death

@export var death_fx: Deathfx
@export var max_health : int

var health : int

func _ready() -> void:
	health = max_health

func die():
	death_fx.die()
	emit_signal("death")

func take_damage():
	health -= 1
	if health <= 0:
		die()
	death_fx.flash()
