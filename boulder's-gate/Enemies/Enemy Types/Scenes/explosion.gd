extends Area2D

@onready var gpu1: GPUParticles2D = $GPUParticles2D
@onready var gpu2: GPUParticles2D = $GPUParticles2D2

func _ready() -> void:
	gpu1.emitting = true
	gpu2.emitting = true
	print("explosion ready")

func _process(_delta: float) -> void:
	print("process")
	if gpu2.emitting == false:
		print("explosion freed")
		queue_free()
