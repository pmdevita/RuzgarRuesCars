extends Camera3D

@export var position_offset: Vector3 = Vector3(-5, 5, 5)
@export var rotation_offset: Vector3 = Vector3(-45, -45, 0)
@export var player: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	global_position = global_position.lerp(player.global_position + position_offset, 0.5)
	# global_rotation = global_rotation.lerp(player.global_rotation + rotation_offset, 0.5)
	
