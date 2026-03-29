extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var puzzle = $"../FlowerPuzzle"
@onready var hint_sprite: Sprite2D = $HintSprite

@export var flower_id: int = 1

var player_in_range = false
var busy = false

func _ready():
	print(get_node_or_null("HintSprite"))
	print(get_node_or_null("Sprite2D"))
	animated_sprite_2d.play("default")
	hint_sprite.visible = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		hint_sprite.visible = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		hint_sprite.visible = false

func _process(_delta):
	if busy:
		return

	if player_in_range and Input.is_action_just_pressed("interact"):
		puzzle.flower_pressed(flower_id)

func play_correct():
	if busy:
		return

	busy = true
	animated_sprite_2d.play("good")

	await animated_sprite_2d.animation_finished

	animated_sprite_2d.play("open")
	busy = false

func force_done():
	busy = false
	animated_sprite_2d.play("open")

func set_default():
	busy = false
	animated_sprite_2d.play("default")
