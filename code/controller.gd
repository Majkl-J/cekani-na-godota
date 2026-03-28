extends Node

var first_level = "res://scenes/rooms/room_1.tscn"

var walk_door_id = -1
var preloaded_player: Resource = preload("res://mobs/blorbo.tscn")

func get_player_resource() -> Resource:
	return preloaded_player

var preloaded_door: Resource = preload("res://mobs/door.tscn")

func get_door_resource() -> Resource:
	return preloaded_door

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

static var room_door_inits = [
	[],
	[{
		"id" = 0,
		"loc" = [340,280]
	}],
	[{
		"id" = 0,
		"loc" = [-340,280]
	},
	{
		"id" = 1,
		"loc" = [280,280]
	}]
]

static var rooms_path = "res://scenes/rooms/"

func get_room_doors(id: int):
	return room_door_inits[id]

func door_link(id: int, current_scene: Node2D):
	var possible_locs = door_links[id]
	for room: String in possible_locs:
		var full_path = rooms_path + room + ".tscn"
		if current_scene.scene_file_path == full_path:
			continue
		walk_door_id = id
		load_and_move_to_room(full_path)
		return

func load_and_move_to_room(room_path: String):
	var new_room = load(room_path)
	get_tree().change_scene_to_packed(new_room)
	return

func get_walk_door_id():
	return walk_door_id
