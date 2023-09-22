extends CharacterBody2D

@export var speed := 50
@export var horizontal_shift := 200
@export var vertical_step := 60
@export var bullet_drop_rate := 1.0/20.0
@export var score_value := 100
@export var bullet_base : PackedScene
@export_enum("Red", "Blue", "Green", "Black") var color_type := 0

var horizontal_dir := 1
var is_descent := false
var distance := 0.0

# Type textures
const type_textures = [
	preload("res://KenneySpaceShooterRedux/PNG/Enemies/enemyRed3.png"),
	preload("res://KenneySpaceShooterRedux/PNG/Enemies/enemyBlue3.png"),
	preload("res://KenneySpaceShooterRedux/PNG/Enemies/enemyGreen3.png"),
	preload("res://KenneySpaceShooterRedux/PNG/Enemies/enemyBlack3.png")	
]

func _ready():
	$Sprite2D.texture = type_textures[color_type]

func _physics_process(delta):
	# The enemy zig-zags downwards
	if is_descent:
		velocity = Vector2.DOWN*speed
	else:
		velocity = Vector2.RIGHT*horizontal_dir*speed
	
	move_and_slide()
	distance += speed*delta
	
	if is_descent:
		if distance >= vertical_step:
			distance = 0.0
			is_descent = false
			horizontal_dir *= -1
	else:
		if distance >= horizontal_shift:
			distance = 0.0
			is_descent = true
			
	
	# Now check if we need to fire a bullet
	var b_odds = exp(-delta*bullet_drop_rate)
	if randf() > b_odds:
		fire_bullet()

func destroy():
	# Hide
	$Sprite2D.visible = false
	# Make intangible
	set_collision_layer_value(3, false)
	# Explode
	$Explosion.explode()
	# Set and start the death timer
	$DeathTimer.start($Explosion.lifetime)
	# The timeout() signal will eventually destroy
	# the whole node once the explosion is over

	# Add the score value
	GameMaster.score += score_value

func fire_bullet():
	var b = bullet_base.instantiate()
	add_sibling(b)
	b.global_position = global_position


func _on_tree_exited():
	# Report destruction
	GameMaster.check_game()
