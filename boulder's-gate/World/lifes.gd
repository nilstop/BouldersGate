extends HBoxContainer

@onready var life_1: TextureRect = $"1"
@onready var life_2: TextureRect = $"2"
@onready var life_3: TextureRect = $"3"


@export var player: CharacterBody2D

var path := "CanvasLayer/Control/MarginContainer/Lifes/%d"

func _ready() -> void:
	player.connect("hit", decrease)

func decrease():
	if Global.p_health > 0:
		get_node("%d" % Global.p_health).hide()
