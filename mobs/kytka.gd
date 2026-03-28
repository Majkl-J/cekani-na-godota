extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var puzzle = $"../FlowerPuzzle"

@export var flower_id: int = 1

var player_in_range = false
var busy = false

func _ready():
	animated_sprite_2d.play("default")

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _process(_delta):
	if busy:
		return

	if player_in_range and Input.is_action_just_pressed("interact"):
		puzzle.flower_pressed(flower_id)

func play_correct():
	if busy:
		return

	busy = true
	print("spoustim good u kytky", flower_id)
	animated_sprite_2d.play("good")

	await animated_sprite_2d.animation_finished

	print("good dokoncena u kytky", flower_id)

	if animated_sprite_2d.sprite_frames.has_animation("open"):
		animated_sprite_2d.play("open")
		print("spoustim open u kytky", flower_id)
	else:
		print("chybi animace open u kytky", flower_id)

	busy = false

func set_default():
	busy = false
	animated_sprite_2d.play("default")
