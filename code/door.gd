class_name Door
extends StaticBody2D

@onready var detect_area: Area2D = $DetectArea
@onready var hint_sprite: CanvasItem = $HintSprite

func _ready() -> void:
	hint_sprite.visible = false
	detect_area.body_entered.connect(_on_body_entered)
	detect_area.body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body is Player:
		hint_sprite.visible = true
		print("player entered door area")

func _on_body_exited(body: Node) -> void:
	if body is Player:
		hint_sprite.visible = false
		print("player exited door area")

func passThrough(_passer: Player) -> bool:
	$"/root/controller".door_link(get_meta("door_id"), get_parent())
	return false
