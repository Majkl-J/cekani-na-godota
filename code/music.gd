extends Node

var player: AudioStreamPlayer

var playlist: Array[AudioStream] = [
	preload("res://sounds/numbthefeelings - glass house (freetouse.com).mp3"),
	preload("res://sounds/Pufino - Arbiters Trial (freetouse.com) (1).mp3"),
	preload("res://sounds/Zambolino - The Living Dead (freetouse.com).mp3")
]

var current_track_index: int = 0

func _ready() -> void:
	player = AudioStreamPlayer.new()
	add_child(player)
	player.bus = "music"
	player.volume_db = -8.0
	player.finished.connect(_on_track_finished)

	if playlist.size() > 0:
		player.stream = playlist[current_track_index]
		player.play()

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
