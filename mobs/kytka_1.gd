extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	animated_sprite_2d.play("default")

var player_in_range = false

func _on_body_entered(body):
	if body.name == "blorbo":
		player_in_range = true
		print("player in range")

func _on_body_exited(body):
	if body.name == "blorbo":
		player_in_range = false
		print("player out of range")

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		animated_sprite_2d.play("good")
