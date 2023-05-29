extends Resource

@export var models: Array[PackedScene] = []

# Make sure that every parameter has a default value.
# Otherwise, there will be problems with creating and editing
# your resource via the inspector.
func _init(p_models: Array[PackedScene] = []):
	models = p_models
