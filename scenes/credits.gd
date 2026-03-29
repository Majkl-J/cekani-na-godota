class_name Credits
extends Node2D

@onready var fade_rect: ColorRect = $FadeRect

func _ready() -> void:
	start_ending()

func start_ending() -> void:
	await get_tree().create_timer(20.0).timeout

	var tween := create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, 10.0)

	await tween.finished
	get_tree().quit()
