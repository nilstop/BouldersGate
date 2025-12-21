extends Node2D

func _physics_process(_delta: float) -> void:
	var area: Area2D = get_parent().hit_area
	var collision = area.get_overlapping_bodies()
	if collision:
		var body = collision[0]
		if body.state != body.States.AIMING and body.current_velocity >= 150:
			die()

func die():
	get_parent().queue_free()
