extends Node
# This class holds general game-wide values required by many
# objects, and signals reporting when they have changed.
# It is included as an AutoLoad singleton in the project

signal lives_set
signal score_set
signal game_over

var lives := 3:
	get:
		return lives
	set(value):
		lives = value
		lives_set.emit(value)
		if value == 0:
			# Game over, no win
			game_over.emit(false)

var score := 0:
	get:
		return score
	set(value):
		score = value
		score_set.emit(value)

func _ready():
	set_process_input(true)
	
func reset():
	lives = 3
	score = 0

func check_game():
	# Check whether there are any enemies left
	var tree = get_tree()
	if tree:
		var enemies = tree.get_nodes_in_group("Enemies")
		if len(enemies) == 0:
			# Game over, win
			game_over.emit(true)

func _input(event):
	if event.is_action_pressed("Restart"):
		var tree = get_tree()
		if tree:
			reset()
			tree.reload_current_scene()
