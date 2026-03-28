class_name Star
extends AbstractLightHandler

var glowing: bool = false
var powered: bool = false

func _ready() -> void:
	pass # Replace with function body.

func _handle_light_collision(light_source: BeemEmitter, hit_pos: Vector2) -> void:
	glowing = true

func _process(delta: float) -> void:
	if glowing == false:
		change_power(false)
	else:
		change_power(true)
	glowing = false

func change_power(new_power: bool = false):
	if(powered == new_power):
		return
	powered = new_power
	update_animation("powered" if new_power else "unpowered")
	return

func update_animation(state: String):
	$AnimatedSprite2D.play(state)
