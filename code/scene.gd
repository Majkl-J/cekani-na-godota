class_name Scene
extends Node2D

var player_plopped: bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var doors = $"/root/controller".get_room_doors(get_meta("room_id"))
	plop_down_doors(doors)
	if not player_plopped:
		plop_down_player(Vector2(0,0))
	plop_down_extras()
	pass # Replace with function body.

func plop_down_doors(doors: Array):
	var to_plop: Resource = $"/root/controller".get_door_resource()
	for door_data: Dictionary in doors:
		var id = door_data["id"]
		var loc = door_data["loc"]
		if(not player_plopped && id == $"/root/controller".get_walk_door_id()):
			plop_down_player(Vector2(loc[0], loc[1]))
		var door: Door = to_plop.instantiate()
		add_child(door)
		door.position = Vector2(loc[0], loc[1])
		door.set_meta("door_id", id)
			
func plop_down_player(where: Vector2) -> void:
	var to_plop: Resource = $"/root/controller".get_player_resource()
	var player: Node2D = to_plop.instantiate()
	add_child(player)
	player.position = where
	player_plopped = true
	return

func plop_down_extras():
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
