extends Node  # Make sure this matches your root node type

func _on_hrat_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/room_1.tscn")

func _on_nastaveni_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/nastaveni.tscn")
