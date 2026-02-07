extends Area2D

@export var dialogue_text := "You made it, Heres the \"Playdate\" for you to take back to P:ear"

@onready var dialogue = $Dialogue

var player: Node = null
var activated := false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	dialogue.visible = false
	
func _process(_delta):
	if activated:
		return
	if player and Input.is_action_just_pressed("interact"):
		_activate()

func _on_body_entered(body):
	if body.name == "Player":
		player = body

func _on_body_exited(body):
	if body == player:
		player = null

func _activate():
	activated = true
	if dialogue:
		dialogue.dialog_text = dialogue_text
		dialogue.popup_centered()
	if player:
		player.has_playdate = true
