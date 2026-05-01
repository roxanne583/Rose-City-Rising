extends Node

var dialogue_ui: CanvasLayer

func _ready():

	# instantiate once
	dialogue_ui = preload("res://scenes/dialogueUI.tscn").instantiate()
	get_tree().root.add_child(dialogue_ui)

func show(text: String, callback: Callable = Callable()):

	dialogue_ui.show_dialogue(text)
	if callback.is_valid():
		dialogue_ui.dialogue_finished.connect(callback, CONNECT_ONE_SHOT)
