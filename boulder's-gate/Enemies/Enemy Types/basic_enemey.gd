extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var hit_area: Area2D = $HitArea
@onready var taking_damage: Node2D = $"Taking Damage Basic"

func die():
	taking_damage.die()
