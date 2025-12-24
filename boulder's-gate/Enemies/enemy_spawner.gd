extends Node2D

@export var player : CharacterBody2D
@export var basic_enemy : PackedScene
@export var large_enemy : PackedScene
@export var deflecting_enemy : PackedScene

var positions : Array = [Rect2i(500,-100,180,0), Rect2i(500,750,180,0), Rect2i(-100,250,0,180), Rect2i(1250,250,0,180)]
@export var start_wave_length: int
@export var start_mini_wave_amount: int
@export var wave_length_increase: int
@export var mini_wave_amount_increase: int
@export var first_deflecting_enemy_wave: int
@export var deflecting_enemy_increase: int
@export var first_large_enemy_wave: int
@export var large_enemy_increase: int

var wave_length
var mini_wave_count
var mini_wave_length


func inst(scene):
	var instance = scene.instantiate()
	var rect : Rect2i = positions[randi_range(0,3)]
	instance.global_position = Vector2(randi_range(rect.position.x, rect.position.x+rect.size.x), randi_range(rect.position.y, rect.position.y+rect.size.y))
	instance.player = get_node("%Player")
	add_child(instance)

func _on_mini_waves_timeout() -> void:
	for i in 3:
		inst(basic_enemy)
	inst(deflecting_enemy)
	if randi_range(0,0) == 0:
		inst(large_enemy)
