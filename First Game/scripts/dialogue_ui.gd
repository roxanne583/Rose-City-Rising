extends CanvasLayer

@onready var panel = $PanelContainer

@onready var label = $PanelContainer/Label

@onready var button = $PanelContainer/Button

signal dialogue_finished

func _ready():

	panel.visible = false
	button.pressed.connect(_on_button_pressed)

func show_dialogue(text: String):

	label.text = text
	panel.visible = true

func _on_button_pressed():

	panel.visible = false
	dialogue_finished.emit()
