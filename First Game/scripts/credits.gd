extends Control

@export var scroll_speed := 30.0

@onready var credits_scroll: ScrollContainer = %CreditsScroll
@onready var back_button: Button = %BackButton

func _ready():
	back_button.pressed.connect(_on_back_pressed)
	credits_scroll.scroll_vertical = 0
	back_button.grab_focus()

func _process(delta):
	var max_scroll = credits_scroll.get_v_scroll_bar().max_value
	if max_scroll <= 0:
		return
	credits_scroll.scroll_vertical += scroll_speed * delta
	if credits_scroll.scroll_vertical >= max_scroll:
		credits_scroll.scroll_vertical = 0

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_back_pressed()

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
