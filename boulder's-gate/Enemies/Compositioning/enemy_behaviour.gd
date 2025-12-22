extends Node2D

func _process(_delta: float) -> void:
	get_parent().look_at(get_parent().player.global_position)
