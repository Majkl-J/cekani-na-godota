class_name Door
extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func passThrough(passer: Player) -> bool:
	$"/root/controller".door_link(get_meta("door_id"), get_parent())
	return false
