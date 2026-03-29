class_name Star
extends AbstractLightHandler

var glowing: bool = false
var powered: bool = false

@onready var con: MasterController = $"/root/controller"

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
	update_animation("powered" if new_power else "unpowered")
	var id = get_meta("id")
	if(con.blockers.has(id)):
		var to_toggle = con.blockers[id]
		for blocker: Blocker in to_toggle:
			blocker.change_state(new_power)
	powered = new_power
	return

func update_animation(state: String):
	$AnimatedSprite2D.play(state)
