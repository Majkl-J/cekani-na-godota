extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	uv_multiplier = uv[2].x / polygon[2].x
	max_len = polygon[2].x
	pass # Replace with function body.

static var uv_multiplier = 1
static var max_len = 200

func get_max_len():
	return max_len

func new_length(len: float):
	polygon[2].x = len
	polygon[3].x = len
	uv[2].x = len * uv_multiplier
	uv[3].x = len * uv_multiplier
	return
