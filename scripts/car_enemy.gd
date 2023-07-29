extends Node3D

@export var model_index: int
var current_model = null

const CRASH_SHADER = preload("res://objects/CarCrashShader.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_model_index(model_index)
	print(current_model)
	apply_shader(0, 2)

	
func set_model_index(index: int):
	var counter = 0
	model_index = index
	for child in %Models.get_children():
		if counter == index:
			child.visible = true
			current_model = child
		else:
			child.visible = false
		counter += 1
		
func get_total_models():
	return %Models.get_child_count()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func apply_shader(crumple_tween, max_height):
	var base_y = current_model.global_position.y - 1
	
	# For each child in that parent, acquire it's ~~flesh~~ mesh
	for child in current_model.find_children("*", "MeshInstance3D", true):
		var mesh = child.mesh
		if mesh.get_class() != "ArrayMesh":
			continue
		# For every surface in that mesh, apply the properties
		for surface in range(child.get_surface_override_material_count()):
			var material = child.get_surface_override_material(surface)
			material.set_shader_parameter("crumple_tween", crumple_tween)
			material.set_shader_parameter("max_height", max_height)
			material.set_shader_parameter("base_y", base_y)
		
# func set_global_shader_property():
	
	
func pre_smash():
	%StaticBody3D.set_collision_layer_value(1, false)
	
func smash():
	apply_shader(1, 1)
	
	
