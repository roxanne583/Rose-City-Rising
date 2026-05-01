extends Control

@onready var menu_button = $VBoxContainer/HBoxContainer/MenuButton

func _ready():

	menu_button.pressed.connect(_on_menu_button_pressed)

func _on_menu_button_pressed():

	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
