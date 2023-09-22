extends CharacterBody2D

@export var speed := 700.0
@export var fire_reload := 0.3
@export var bullet_base: PackedScene

var alive := true
var reload_time := 0.0

func _physics_process(delta):
	
	if alive:
		# Capture the movement; edges will stop us left and right	
		var dx = Input.get_axis("MoveLeft", "MoveRight")
		#move_and_collide(Vector2.RIGHT*speed*dx*delta)
		velocity = Vector2.RIGHT*speed*dx
		move_and_slide()
		
		# Do we need to fire?
		if reload_time <= 0.0:
			if Input.is_action_pressed("Fire"):
				fire_gun()
				reload_time = fire_reload
		else:
			# This makes reload time go towards zero so that it'll be ready
			# to fire again in fire_reload seconds
			reload_time = move_toward(reload_time, 0.0, delta)
			
func fire_gun():
	
	# We instantiate two bullets; the nodes LeftGun and RightGun
	# control the firing positions
	
	var bl = bullet_base.instantiate()
	var br = bullet_base.instantiate()
	
	add_sibling(bl)
	add_sibling(br)
	
	bl.global_position = $LeftGun.global_position
	br.global_position = $RightGun.global_position
	
	# Play sound
	$LaserSound.play()

func lose_life():
	if alive:
		# Hide the spride
		$PlayerSprite.visible = false
		# Start the explosion
		$Explosion.explode()
		# Turn off the rest of the processing
		alive = false
		# Remove one life
		GameMaster.lives -= 1
		# If we still have lives left, schedule revival
		if GameMaster.lives > 0:
			$RevivalTimer.start()
	
func revive():
	alive = true
	$PlayerSprite.visible = true
	reload_time = 0.0
