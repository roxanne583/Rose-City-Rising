extends Control

@onready var start_button = %StartButton
@onready var credits_button = %CreditsButton

func _ready():
	start_button.pressed.connect(_on_start_pressed)
	credits_button.pressed.connect(_on_credits_pressed)
	start_button.grab_focus()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/credits.tscn")
