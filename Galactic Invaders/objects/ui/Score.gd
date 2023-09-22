extends Label


func _ready():
	text = str(GameMaster.score)
	GameMaster.score_set.connect(Callable(self, "update_score"))
	
func update_score(value: int):
	text = str(value)
