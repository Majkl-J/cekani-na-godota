extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var puzzle = $"../FlowerPuzzle"

@export var flower_id: int = 1

var player_in_range = false

func _ready():
	animated_sprite_2d.play("default")
	print("kytka ready:", name, " id:", flower_id)

func _on_area_2d_body_entered(body):
	print("body entered:", body.name)
	if body.is_in_group("player"):
		player_in_range = true
		print("player in range:", flower_id)

func _on_area_2d_body_exited(body):
	print("body exited:", body.name)
	if body.is_in_group("player"):
		player_in_range = false
		print("player out of range:", flower_id)

func _on_area_2d_area_entered(area):
	print("area entered:", area.name)
	if area.is_in_group("player"):
		player_in_range = true
		print("player in range via area:", flower_id)

func _on_area_2d_area_exited(area):
	print("area exited:", area.name)
	if area.is_in_group("player"):
		player_in_range = false
		print("player out of range via area:", flower_id)

func _process(_delta):
	if Input.is_action_just_pressed("interact"):
		print("E u kytky", flower_id, "| in_range =", player_in_range)

	if player_in_range and Input.is_action_just_pressed("interact"):
		print("zmacknuta kytka:", flower_id)
		puzzle.flower_pressed(flower_id)

func set_good():
	animated_sprite_2d.play("good")

func set_default():
	animated_sprite_2d.play("default")
