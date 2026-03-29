extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
var interacting_with = false

var valid_inputs = ["2100", "21.00", "21:00"]

func handle_interact():
	if interacting_with:
		$"/root/controller".block_movement = false
		$BudikControl.visible = false
		interacting_with = false
	elif not $"/root/controller".budik_complete:
		$"/root/controller".block_movement = true
		$BudikControl.visible = true
		interacting_with = true

func _on_interaction_object_interacted_with(event: InputEvent, player: Player) -> void:
	if Input.is_action_just_pressed("interact"):
		handle_interact()
	pass # Replace with function body.


func _on_line_edit_text_submitted(new_text: String) -> void:
	if(valid_inputs.find(new_text) != -1): # Replace with function body.
		handle_interact()
		$"/root/controller".complete_budik()
