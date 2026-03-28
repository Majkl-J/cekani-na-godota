class_name Door
extends StaticBody2D


func passThrough(_passer: Player) -> bool:
	$"/root/controller".door_link(get_meta("door_id"), get_parent())
	return false
