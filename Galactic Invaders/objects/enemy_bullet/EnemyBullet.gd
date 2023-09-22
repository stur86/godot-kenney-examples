extends CharacterBody2D

@export var speed := 200.0

func _ready():
	velocity = Vector2.DOWN*speed
	
func _physics_process(delta):
	var coll = move_and_collide(velocity*delta)
	
	if coll != null:
		var cbody = coll.get_collider()
		if cbody.has_method("lose_life"):
			cbody.lose_life()
			queue_free()
