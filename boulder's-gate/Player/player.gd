extends CharacterBody2D

@export var boulder : CharacterBody2D
@export var speed : int
@export var accel : int 

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	get_input()
	move_and_slide()
