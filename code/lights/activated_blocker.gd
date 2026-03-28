class_name Blocker extends StaticBody2D

@onready var con: MasterController = $"/root/controller"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	con.add_to_blockers(self)
	change_state(false)
	return

func _exit_tree() -> void:
	con.remove_from_blockers(self)
	return

func change_state(new_state: bool):
	var actual_state: bool = new_state != get_meta("inverted")
	if(actual_state == false):
		visible = true
		$Collider.disabled = false
	else:
		visible = false
		$Collider.disabled = true
	return
