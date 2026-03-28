class_name AbstractLightHandler
extends StaticBody2D


func _handle_light_collision(light_origin: Vector2, _light_source: BeemEmitter) -> void:
	pass

var emitters: Dictionary[BeemEmitter, BeemEmitter] = {}

func add_emitter(new_rotation: float, light_source: BeemEmitter):
	if emitters.has(light_source):
		rotate_emitter(new_rotation, light_source)
		return
	var emitter: BeemEmitter = $"/root/controller".get_emitter_resource().instantiate()
	add_child(emitter)
	emitter.rotation = new_rotation
	emitter.add_exception(self)
	emitters[light_source] = emitter
	return
	
func rotate_emitter(new_rotation: float, light_source: BeemEmitter):
	var emitter: BeemEmitter = emitters[light_source]
	emitter.rotation = new_rotation
	return

func remove_emitter(light_source: BeemEmitter):
	var emitter: BeemEmitter = emitters[light_source]
	emitters[light_source] = null
	remove_child(emitter)
	emitter.free()
	return

func remove_emitters():
	for emitter in emitters:
		var to_remove = emitters[emitter]
		remove_child(to_remove)
		emitters.erase(emitter)
		to_remove.free()
