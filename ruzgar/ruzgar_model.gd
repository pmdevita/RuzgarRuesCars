extends Node3D

@export var game_manager: Node3D
var parent: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	parent = get_parent()
	%AnimationTree["parameters/runblend/blend_amount"] = 0.8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if parent.is_running:
		%AnimationPlayer.play("02-happyrun")
