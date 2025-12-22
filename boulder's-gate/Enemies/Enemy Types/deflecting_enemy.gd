extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var taking_damage: Node2D = $"Taking Damage Deflect"
@onready var death_fx: Deathfx = $DeathFx

func die():
	death_fx.die()

func take_damage():
	taking_damage.take_damage()
