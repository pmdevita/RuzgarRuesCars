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
	global_position = global_position.lerp(player.global_position + position_offset, 0.2)
	var basis = Basis.looking_at(player.global_position - global_position)
	var lookat = Transform3D(Basis.looking_at(player.global_position - global_position), global_position)
	global_transform.basis = global_transform.basis.slerp(basis, 0.01)
	
