extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	GameMaster.game_over.connect(Callable(self, "on_game_over"))

func on_game_over(win: bool):
	
	visible = true
	if win:
		text = "YOU WIN"
	else:
		text = "GAME OVER"
