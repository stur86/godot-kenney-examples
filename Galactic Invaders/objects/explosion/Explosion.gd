extends CPUParticles2D


func explode():
	restart()
	emitting = true
	# Play sound
	$BoomSound.play()
