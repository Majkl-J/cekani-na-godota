class_name MasterController extends Node

# Pro nápovědu
var used_left_hint: bool = false
var used_right_hint: bool = false
var used_jump_hint: bool = false

var first_scene = "res://scenes/menu.tscn"
var first_level = "res://scenes/rooms/room_1.tscn"

var volume = 50

func set_volume(new_volume: float):
	volume = new_volume
	print("Volume now ", volume)

var walk_door_id = -1
var preloaded_player: Resource = preload("res://mobs/blorbo.tscn")

func get_player_resource() -> Resource:
	return preloaded_player

var preloaded_door: Resource = preload("res://mobs/door.tscn")

func get_door_resource() -> Resource:
	return preloaded_door

var preloaded_beem: Resource = preload("res://scenes/beam_poly.tscn")

func get_beem_resource() -> Resource:
	return preloaded_beem

var preloaded_emitter: Resource = preload("res://scenes/beam_emitter.tscn")

func get_emitter_resource() -> Resource:
	return preloaded_emitter

# this is a mistake
static var max_len: float = 270
func get_max_len():
	return max_len

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_level(first_scene)
	
	player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = "music"
	player.volume_db = -8.0
	player.finished.connect(_on_track_finished)

	if playlist.size() > 0:
		player.stream = playlist[current_track_index]
		player.play()
	#pass # Replace with function body.

func load_actual_game():
	load_level(first_level)

func load_level(path):
	var f = load(path)
	get_tree().change_scene_to_packed(f)
	return

func get_main_node() -> Node:
	return get_tree().root.get_child(1)


static var blockers: Dictionary[int, Array] = {}

func add_to_blockers(to_add: Blocker):
	var id = to_add.get_meta("id")
	if(blockers.find_key(id)):
		blockers[id].append(to_add)
	else:
		blockers.set(id, [to_add])

func remove_from_blockers(to_wipe: Blocker):
	var id = to_wipe.get_meta("id")
	var funny_array = blockers[id]
	var loc = funny_array.rfind(to_wipe)
	funny_array.remove_at(loc)
	blockers[id] = funny_array

static var door_links = {
	0: ["room_1","room_2"],
	1: ["room_2","room_3"]
}

static var room_door_inits = [
	[],
	[{
		"id" = 0,
		"loc" = [340,-15]
	}],
	[{
		"id" = 0,
		"loc" = [-40,-15]
	},
	{
		"id" = 1,
		"loc" = [343,-15]
	}],
	[{
		"id" = 1,
		"loc" = [-340,-15]
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

static var flowers_complete: bool = false

var player: AudioStreamPlayer

var playlist: Array[AudioStream] = [
	preload("res://sounds/numbthefeelings - glass house (freetouse.com).mp3"),
	preload("res://sounds/Pufino - Arbiters Trial (freetouse.com) (1).mp3"),
	preload("res://sounds/Zambolino - The Living Dead (freetouse.com).mp3")
]

var current_track_index: int = 0

# Music
func _on_track_finished() -> void:
	if playlist.is_empty():
		return

	current_track_index = (current_track_index + 1) % playlist.size()
	player.stream = playlist[current_track_index]
	player.play()

func play_playlist() -> void:
	if playlist.is_empty():
		return

	if not player.playing:
		player.stream = playlist[current_track_index]
		player.play()

func stop_music() -> void:
	player.stop()

func next_track() -> void:
	if playlist.is_empty():
		return

	current_track_index = (current_track_index + 1) % playlist.size()
	player.stop()
	player.stream = playlist[current_track_index]
	player.play()

func previous_track() -> void:
	if playlist.is_empty():
		return

	current_track_index = (current_track_index - 1 + playlist.size()) % playlist.size()
	player.stop()
	player.stream = playlist[current_track_index]
	player.play()
