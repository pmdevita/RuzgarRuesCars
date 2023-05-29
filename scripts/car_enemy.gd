extends Node3D

@export var model_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	set_model_index(model_index)

	
func set_model_index(index: int):
	var counter = 0
	for child in %Models.get_children():
		if counter == index:
			child.visible = true
		else:
			child.visible = false
		counter += 1
		
func get_total_models():
	return %Models.get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func pre_smash():
	%StaticBody3D.set_collision_layer_value(1, false)
	
func smash():
	pass
	
