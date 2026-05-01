extends Area2D


@export var intro_text := "We need to pickup \"Playdates\" from \"Panic!\" in downtown. Let's skate"

@export var reminder_text := "Is everything good pal? You should hurry and pickup the \"Playdate\" before p:ear closes."

@export var completion_text := "You rock! Wired Wednesday will be happy. Let's see what p:ear's skate club is up to."

@onready var dialogue_panel = $CanvasLayer/PanelContainer

@onready var dialogue_label = $CanvasLayer/PanelContainer/Label

@onready var dialogue_button = $CanvasLayer/PanelContainer/Button

var player: Node = null

var completion_pending := false

var intro_shown := false

func _ready():

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	dialogue_panel.visible = false
	dialogue_button.pressed.connect(_on_dialogue_confirmed)
	_show_intro()

func _process(_delta):

	if not player:
		return
	if dialogue_panel.visible:
		return
	if Input.is_action_just_pressed("interact"):
		_show_interaction_dialogue()

func _on_body_entered(body):

	if body.name == "Player":
		player = body

func _on_body_exited(body):

	if body == player:
		player = null

func _show_intro():

	if intro_shown:
		return
	intro_shown = true
	dialogue_label.text = intro_text
	dialogue_panel.visible = true

func _show_interaction_dialogue():

	if player and player.has_playdate:
		completion_pending = true
		dialogue_label.text = completion_text
	else:
		completion_pending = false
		dialogue_label.text = reminder_text
	dialogue_panel.visible = true

func _on_dialogue_confirmed():

	dialogue_panel.visible = false
	if completion_pending:
		completion_pending = false
		GameManager.trigger_victory()
