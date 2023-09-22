extends Node
# This class holds general game-wide values required by many
# objects, and signals reporting when they have changed.
# It is included as an AutoLoad singleton in the project

signal lives_set
var lives := 3:
	get:
		return lives
	set(value):
		lives = value
		lives_set.emit(value)

signal score_set
var score := 0:
	get:
		return score
	set(value):
		score = value
		score_set.emit(value)
