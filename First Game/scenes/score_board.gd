extends CanvasLayer

@onready var score_label = $MarginContainer/ScoreLabel
@onready var time_label = $TimeLabel

var current_score := 0
var current_time := 180

func _ready():
	update_score_label()
	update_time_label()

func set_score(score := 0):
	current_score = score
	update_score_label()

func add_score(amount := 0):
	current_score += amount
	update_score_label()

func set_time(time := 180):
	current_time = time
	update_time_label()

func update_score_label():
	score_label.text = "Score: " + str(current_score)

func update_time_label():
	time_label.text = "Time: " + str(current_time)