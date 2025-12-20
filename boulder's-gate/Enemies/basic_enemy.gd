extends CharacterBody2D

@onready var player: CharacterBody2D
@onready var boulder_area: Area2D = $BoulderArea


@export var speed : int

func _physics_process(_delta: float) -> void:
	velocity = Vector2.RIGHT.rotated(rotation) * speed
	move_and_slide()
	check_boulder_collision()

func _process(_delta: float) -> void:
	look_at(player.global_position)

func die():
	queue_free()

func check_boulder_collision():
	if boulder_area.has_overlapping_bodies():
		var body = boulder_area.get_overlapping_bodies()[0]
		if body.state == body.States.ROLLING:
			die()
		#for body in boulder_area.get_overlapping_bodies():
		#	if body.is_in_group("boulder"):
		#		if body.state == body.States.ROLLING:
		#			die()
