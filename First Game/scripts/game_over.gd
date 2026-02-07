extends Control

@onready var menu_button = %MenuButton


func _on_menu_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/start_menu.tscn")
