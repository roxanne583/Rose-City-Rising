extends Control

@onready var menu_button = %MenuButton


func _on_menu_button_pressed():
	Engine.time_scale = 1.0
	get_tree().paused = false
	get_tree().call_deferred("change_scene_to_file", "res://scenes/start_menu.tscn")
