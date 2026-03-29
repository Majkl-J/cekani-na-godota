extends AbstractLightHandler

func _ready() -> void:
	var current_room: Scene = $"/root/controller".get_main_node()
	if not current_room.get_meta("room_id") == 3:
		visible = false


func _handle_light_collision(light_source: BeemEmitter, hit_pos: Vector2) -> void:
	$"/root/controller".complete_lights()
