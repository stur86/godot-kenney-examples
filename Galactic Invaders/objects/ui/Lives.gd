extends HBoxContainer

@export var life_base: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	# Creating the counters (based on number of lives)
	for i in range(GameMaster.lives):
		var l = life_base.instantiate()
		add_child(l)
	
	# Connecting to the signal that fires when the lives change
	GameMaster.lives_set.connect(Callable(self, "edit_lives"))
	
func edit_lives(value: int):
	
	# We get the child count. If it's higher than value,
	# the excess will be deleted
	var child_n = get_child_count()
	print(child_n, " ", value)
	if value < child_n:
		# Remove excess
		for i in range(value, child_n):
			remove_child(get_child(i))
	elif value > child_n:
		# Add more
		for i in range(child_n, value):
			var l = life_base.instantiate()
			add_child(l)
			
