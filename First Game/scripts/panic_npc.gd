extends Area2D

@export var dialogue_text := "You made it, Heres the \"Playdate\" for you to take back to P:ear"

var player: Node = null

var activated := false

@onready var dialog_button = %DialogCloseButton

@onready var label = %Label

func _ready():

	print("Button is:", dialog_button)  # debug
	dialog_button.pressed.connect(_on_dialog_close_pressed)

func _on_dialog_close_pressed():

	print("BUTTON CLICKED ✅")
	get_tree().change_scene_to_file("res://scenes/level.tscn")
