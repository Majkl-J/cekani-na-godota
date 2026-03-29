extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var detect_area: Area2D = $Area2D
@onready var hint_sprite: Sprite2D = $Sprite2D

var player_in_range = false

func _ready() -> void:
	hint_sprite.visible = true
	animated_sprite_2d.play("default")

	detect_area.body_entered.connect(_on_body_entered)
	detect_area.body_exited.connect(_on_body_exited)
	print("signals connected")

	print("detect_area =", detect_area)
	print("hint_sprite =", hint_sprite)

func _on_body_entered(body: Node) -> void:
	print(body.name)
	hint_sprite.visible = true
	if body.name == "blorbo":
		player_in_range = true
		hint_sprite.visible = true
		print("player in range")

func _on_body_exited(body: Node) -> void:
	if body.name == "blorbo":
		player_in_range = false
		hint_sprite.visible = false
		print("player out of range")

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		animated_sprite_2d.play("good")
