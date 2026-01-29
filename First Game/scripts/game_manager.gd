extends Node

@onready var score_board = get_node_or_null("%ScoreBoard")
@onready var score_label = score_board.get_node_or_null("MarginContainer/ScoreLabel") if score_board else null
@onready var time_label = score_board.get_node_or_null("TimeLabel") if score_board else null
@onready var lives_label = score_board.get_node_or_null("LivesLabel") if score_board else null
@onready var game_over_label = score_board.get_node_or_null("GameOverLabel") if score_board else null
@onready var player = get_node_or_null("%Player")

@export var max_lives := 3
@export var start_time := 180
@export var countdown_enabled := true

var current_score := 0
var current_time := 180
var current_lives := 3
var spawn_position := Vector2.ZERO
var game_over := false
var countdown_timer: Timer = null

func _ready():
	add_to_group("game_manager")
	if player:
		spawn_position = player.global_position
	current_lives = max_lives
	current_time = start_time
	update_score_label()
	update_time_label()
	update_lives_label()
	hide_game_over()
	if countdown_enabled:
		start_countdown()

func set_score(score := 0):
	current_score = score
	update_score_label()

func add_score(amount := 0):
	current_score += amount
	update_score_label()

func set_time(time := 180):
	current_time = time
	update_time_label()
	if current_time <= 0:
		trigger_game_over()

func lose_life():
	if game_over:
		return
	current_lives = max(current_lives - 1, 0)
	update_lives_label()
	if current_lives <= 0:
		trigger_game_over()

func respawn_player(victim: Node):
	if game_over:
		return
	if not victim:
		return
	if victim is CharacterBody2D:
		victim.velocity = Vector2.ZERO
	victim.global_position = spawn_position
	var collision_shape = victim.get_node_or_null("CollisionShape2D")
	if collision_shape:
		collision_shape.disabled = false
	victim.set_process_input(true)
	victim.set_process(true)
	victim.set_physics_process(true)

func set_spawn_position(position: Vector2):
	spawn_position = position

func start_countdown():
	if countdown_timer:
		return
	countdown_timer = Timer.new()
	countdown_timer.wait_time = 1.0
	countdown_timer.one_shot = false
	add_child(countdown_timer)
	countdown_timer.timeout.connect(_on_countdown_timeout)
	countdown_timer.start()

func _on_countdown_timeout():
	if game_over:
		return
	current_time = max(current_time - 1, 0)
	update_time_label()
	if current_time <= 0:
		trigger_game_over()

func update_score_label():
	if score_label:
		score_label.text = "Score: " + str(current_score)

func update_time_label():
	if time_label:
		time_label.text = "Time: " + str(current_time)

func update_lives_label():
	if lives_label:
		lives_label.text = "Lives: " + str(current_lives)

func trigger_game_over():
	game_over = true
	if countdown_timer:
		countdown_timer.stop()
	show_game_over()
	if player:
		player.set_physics_process(false)

func show_game_over():
	if game_over_label:
		game_over_label.visible = true

func hide_game_over():
	if game_over_label:
		game_over_label.visible = false
