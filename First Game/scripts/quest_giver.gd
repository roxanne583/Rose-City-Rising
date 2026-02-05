extends Area2D

@export var intro_text := "Welcome to Rose CIty Rising! Can you do me favor and skate across town and pick up a \"Playdate\" from \"Panic\". I'll save you a plate from P;ear. Thanks friend!"
@export var reminder_text := "Is everything good pal? You should hurry and pickup the \"Playdate\" before P;ear closes."
@export var completion_text := "Thanks friend! You were so fast and cool! I'm glad we met. Here's that plate I saved you."

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
