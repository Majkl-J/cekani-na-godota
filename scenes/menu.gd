extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	$"/root/controller".load_actual_game()


func _on_settings_pressed() -> void:
	$SettingsMenu.visible = !$SettingsMenu.visible


func _on_volume_slider_value_changed(value: float) -> void:
	$"/root/controller".set_volume(value)
