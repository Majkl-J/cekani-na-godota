class_name InteractionArea extends Area2D

signal interacted_with(event: InputEvent, player: Player)

var popup: Node2D = null

var popups: Dictionary[String, Resource] = {
	"" = preload("res://object/interaction_popups/interactable_popup.tscn"),
	"E" = preload("res://object/interaction_popups/interactable_popup_e.tscn"),
	"MIRROR" = preload("res://object/interaction_popups/interactable_popup_mirr.tscn"),
	"SPLITTER" = preload("res://object/interaction_popups/interactable_popup_split.tscn"),
	"ENTER" = preload("res://object/interaction_popups/interactable_popup_enter.tscn")
}

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	var metashit = get_meta("interaction_type")
	if popup != null:
		freepopup()
	if popups.has(metashit):
		popup = popups[metashit].instantiate()
		$"/root/controller".get_main_node().add_child(popup)
		popup.global_position = global_position

func _unhandled_input(event: InputEvent) -> void:
	for hit: Node2D in get_overlapping_bodies():
		if hit is Player:
			interacted_with.emit(event, hit)

func freepopup():
	popup.free()
	popup = null

func _on_body_exited(body: Node2D) -> void:
	if body is not Player:
		return
	freepopup()


func _on_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
