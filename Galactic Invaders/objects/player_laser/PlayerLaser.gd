extends CharacterBody2D

const speed := 1000.0
	
func _physics_process(delta):
	# The bullet always moves upwards at fixed speed;
	# once outside the screen, the VisibilityNotifier will destroy it
	# (see the screen_exited signal, which is connected to queue_free)
	var coll = move_and_collide(Vector2.UP*speed*delta)
	
	if coll:
		var cbody = coll.get_collider()
		if cbody.has_method("destroy"):
			cbody.destroy()
			queue_free()
