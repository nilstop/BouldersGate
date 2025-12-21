extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var taking_damage: Node2D = $"Taking Damage Deflect"

func die():
	taking_damage.die()

func take_damage():
	taking_damage.take_damage()
