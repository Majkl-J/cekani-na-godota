class_name InteractionArea extends Area2D

signal interacted_with(event: InputEvent, player: Player)

var popup: Node2D = null

var popups: Dictionary[String, Resource] = {
	"" = preload("res://object/interaction_popups/interactable_popup.tscn"),
	"E" = preload("res://object/interaction_popups/interactable_popup_e.tscn"),
	"MIRROR" = preload("res://object/interaction_popups/interactable_popup_mirr.tscn"),
	"SPLITTER" = preload("res://object/interaction_popups/interactable_popup_split.tscn")
}

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		return
	var metashit = get_meta("interaction_type")
	if popup != null:
		freepopup()
	if popups.has(metashit):
		popup = popups[metashit].instantiate()
		add_child(popup)

func freepopup():
	remove_child(popup)
	popup.free()
	popup = null

func _on_body_exited(body: Node2D) -> void:
	if body is not Player:
		return
	freepopup()
