extends Node  # Make sure this matches your root node type

func _on_zpet_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
