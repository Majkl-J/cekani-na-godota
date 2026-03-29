extends Node

@onready var kytka1 = $"../kytka1"
@onready var kytka2 = $"../kytka2"
@onready var kytka3 = $"../kytka3"
@onready var kytka4 = $"../kytka4"

var correct_order = [1, 3, 2, 4]
var current_step = 0

func _ready() -> void:
	if($"/root/controller".flowers_complete):
		kytka1.force_done()
		kytka2.force_done()
		kytka3.force_done()
		kytka4.force_done()
		return
	correct_order.shuffle()

func flower_pressed(flower_id: int):
	if $"/root/controller".flowers_complete:
		return

	if current_step >= correct_order.size():
		$"/root/controller".flowers_complete = true
		return

	if flower_id == correct_order[current_step]:
		var flower = get_flower_by_id(flower_id)
		if flower != null:
			flower.play_correct()
		current_step += 1

		if current_step >= correct_order.size():
			$"/root/controller".flowers_complete = true
			puzzle_done()
	else:
		reset_puzzle()

func get_flower_by_id(flower_id):
	match flower_id:
		1: return kytka1
		2: return kytka2
		3: return kytka3
		4: return kytka4
	return null

func reset_puzzle():
	if $"/root/controller".flowers_complete:
		return

	current_step = 0
	kytka1.set_default()
	kytka2.set_default()
	kytka3.set_default()
	kytka4.set_default()

func puzzle_done():
	$"/root/controller".complete_flowers()
