extends Node

var first_level = "res://scenes/rooms/room_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(first_level)
	pass # Replace with function body.
	
func load_level(path):
	var f = load(path)
	get_tree().change_scene_to_packed(f)
	return

func get_main_node() -> Node:
	return get_tree().root.get_child(1)

static var door_links = {
	0: ["room_1","room_2"],
	1: ["room_2","room_3"]
}

static var rooms_path = "res://scenes/rooms/"

func door_link(id: int, current_scene: Node2D):
	var possible_locs = door_links[id]
	for room: String in possible_locs:
		var full_path = rooms_path + room + ".tscn"
		if current_scene.scene_file_path == full_path:
			continue
		load_and_move_to_room(full_path)
		return

func load_and_move_to_room(room_path: String):
	var new_room = load(room_path)
	get_tree().change_scene_to_packed(new_room)
	return
