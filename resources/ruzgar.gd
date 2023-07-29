extends CharacterBody3D

var is_running = true
@export var base_speed = 0.25
@export var jump_force = 9.0
@export var gravity = 9.0
@export var left_lane = -9.0
@export var lane_size = 10.0
@export var lane = 0
var has_attacked_midair = false
var current_car = null
var enable_gravity = true
var enable_velocity = true

# Called when the node enters the scene tree for the first time.
func _ready():
	set_lane_position()

func set_lane_position():
	global_position.z = lane * lane_size + left_lane

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_left"):
		lane -= 1
		set_lane_position()
	if Input.is_action_just_pressed("game_right"):
		lane += 1
		set_lane_position()
	
func _physics_process(delta):
	var newVel = Vector3(base_speed, 0, 0)
	# If the player jumped...
	if Input.is_action_just_pressed("game_jump"):
		# If they were on the floor, send them into the air
		if is_on_floor():
			has_attacked_midair = false
			velocity.y = jump_force
			newVel.y += jump_force
		# If they were in the air, try to perform a smash
		elif not has_attacked_midair:
			has_attacked_midair = true
			var car = %CarDetect.get_car()
			if car != null:
				current_car = car
				var car_position = car.global_position
				car_position.z = global_position.z
				car_position.x -= 2
				enable_gravity = false
				look_at(car_position, Vector3(0, 1, 0).normalized())
				rotation.x += 90
				velocity = global_position.direction_to(car_position) * 70
				car.pre_smash()
				# Pause in midair for effect
				enable_velocity = false
				%SmashHold.start()
				await %SmashHold.timeout
				enable_velocity = true
	
	# If we are touching the ground, make sure gravity is enabled and the player is rotated correctly
	# This usually happens after a jump lands
	if not enable_gravity and is_on_floor():
		enable_gravity = true
		# Make sure we also mark that we are no longer attacking in midair
		has_attacked_midair = false
		current_car = null
		rotation_degrees = Vector3(0, -90, 0)
	
	# Calculate gravity if enabled
	if enable_gravity:
		newVel.y += gravity
		velocity = velocity.lerp(newVel, 0.1)
	
	# Apply velocity
	if is_running and enable_velocity:
		move_and_slide()
		
	# Prevent player from dropping below the map
	global_position.y = max(global_position.y, -2)



func _on_area_3d_area_entered(area):
	print("car!", area)


func _on_smash_hitbox_body_entered(body):
	if has_attacked_midair and current_car:
		current_car.smash()
		current_car = null
		enable_velocity = false
		
