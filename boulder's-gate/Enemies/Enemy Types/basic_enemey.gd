extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var hit_area: Area2D = $HitArea
@onready var death_fx: Deathfx = $DeathFx

func die():
	death_fx.die()
