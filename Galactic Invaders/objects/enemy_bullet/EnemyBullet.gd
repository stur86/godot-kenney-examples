extends CharacterBody2D

@export var speed := 200.0

func _ready():
	velocity = Vector2.DOWN*speed
	# On game over, instantaneously disappears
	GameMaster.game_over.connect(Callable(self, "_on_game_over"))
	
func _physics_process(delta):
	var coll = move_and_collide(velocity*delta)
	
	if coll != null:
		var cbody = coll.get_collider()
		if cbody.has_method("lose_life"):
			cbody.lose_life()
			queue_free()

func _on_game_over(_win: bool):
	queue_free()
