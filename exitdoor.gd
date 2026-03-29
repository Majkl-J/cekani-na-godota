class_name ExitDoor
extends StaticBody2D

static var open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"/root/controller".exit = self
	update_locks()

func update_locks():
	var controller: MasterController = $"/root/controller"
	if(controller.budik_complete):
		$Sprite2D/Zamek1.visible = false
	if(controller.flowers_complete):
		$Sprite2D/Zamek2.visible = false
	if(controller.lights_complete):
		$Sprite2D/Zamek3.visible = false
	if(controller.budik_complete && controller.flowers_complete && controller.lights_complete):
		open = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_interaction_object_area_interacted_with(event: InputEvent, player: Player) -> void:
	if Input.is_action_just_pressed("open"):
		if open && $"/root/controller".get_main_node().get_meta("room_id") == 1:
			#load scene here
			return
