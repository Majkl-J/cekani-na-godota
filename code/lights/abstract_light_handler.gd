class_name AbstractLightHandler
extends StaticBody2D


func _handle_light_collision(light_source: BeemEmitter, hit_pos: Vector2) -> void:
	pass

var emitters: Dictionary[BeemEmitter, BeemEmitter] = {}

func compile_origin_sources() -> Array[BeemEmitter]:
	var all_sources: Array[BeemEmitter] = []
	for i in emitters:
		var emitter:BeemEmitter = emitters[i]
		all_sources.push_back(emitter.origin_emitter)
	return all_sources

func add_emitter(new_rotation: float, light_source: BeemEmitter, hit_pos: Vector2):
	if emitters.has(light_source):
		rotate_emitter(new_rotation, light_source, hit_pos)
		return
	if(light_source.origin_emitter in compile_origin_sources()):
		return
	var emitter: BeemEmitter = $"/root/controller".get_emitter_resource().instantiate()
	add_child(emitter)
	emitter.rotation = new_rotation
	emitter.position = to_local(hit_pos)
	emitter.origin_emitter = light_source.origin_emitter
	emitter.add_exception(self)
	emitters[light_source] = emitter
	return
	
func rotate_emitter(new_rotation: float, light_source: BeemEmitter, hit_pos: Vector2):
	var emitter: BeemEmitter = emitters[light_source]
	emitter.rotation = new_rotation
	emitter.position = to_local(hit_pos)
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
