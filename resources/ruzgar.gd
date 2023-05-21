extends CharacterBody3D

var isRunning = true
@export var base_speed = 0.25

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	global_position.x += base_speed
	if isRunning:
		move_and_slide()
	
