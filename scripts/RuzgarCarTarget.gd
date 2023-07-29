extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_car():
	var cars = get_overlapping_bodies()
	if cars.size() == 0:
		return null
	cars.sort_custom(sort_cars)
	return cars[0].get_parent()


func sort_cars(a, b):
	return a.global_position.x < b.global_position.x
	
