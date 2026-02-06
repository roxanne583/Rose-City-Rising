extends Area2D

@export var intro_text := "We need to pickup \"Playdates\" from \"Panic!\" in downtown. Let's skate"
@export var reminder_text := "Is everything good pal? You should hurry and pickup the \"Playdate\" before p:ear closes."
@export var completion_text := "You rock! Wired Wednesday will be happy. Let's see what p:ear's skate club is up to."

@onready var dialogue = $Dialogue
@onready var game_manager = %GameManager

var player: Node = null
var completion_pending := false
var intro_shown := false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	dialogue.visible = false
	dialogue.confirmed.connect(_on_dialogue_confirmed)
	_show_intro()

func _process(delta):
	if not player:
		return
	if dialogue.visible:
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
	dialogue.dialog_text = intro_text
	dialogue.popup_centered()

func _show_interaction_dialogue():
	if player and player.has_playdate:
		completion_pending = true
		dialogue.dialog_text = completion_text
	else:
		completion_pending = false
		dialogue.dialog_text = reminder_text
	dialogue.popup_centered()

func _on_dialogue_confirmed():
	if completion_pending and game_manager:
		completion_pending = false
		game_manager.trigger_victory()
