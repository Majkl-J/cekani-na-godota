class_name BeemPoly extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	uv_multiplier = uv[2].x / polygon[2].x

static var uv_multiplier = 1

func set_length(new_length: float):
	polygon[2].x = new_length
	polygon[3].x = new_length
	uv[2].x = new_length * uv_multiplier
	uv[3].x = new_length * uv_multiplier
	return
