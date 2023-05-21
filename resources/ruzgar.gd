extends CharacterBody3D

var isRunning = true
@export var base_speed = 0.25
@export var jump_force = 9


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var newVel = Vector3(base_speed, -9, 0)
	if Input.is_action_pressed("game_jump") and is_on_floor():
		velocity.y = jump_force
		newVel.y += jump_force
		
	velocity = velocity.lerp(newVel, 0.1)
		
	print(global_position)
	if isRunning:
		move_and_slide()
	global_position.y = max(global_position.y, -2)
