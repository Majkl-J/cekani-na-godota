extends Node

@onready var kytka1 = $"../kytka1"
@onready var kytka2 = $"../kytka2"
@onready var kytka3 = $"../kytka3"
@onready var kytka4 = $"../kytka4"
@onready var zamek1 = $"../Zamek1"

var correct_order = [1, 3, 2, 4]
var current_step = 0
var puzzle_finished = false

func flower_pressed(flower_id: int):
	if puzzle_finished:
		print("puzzle uz hotovy")
		return

	if current_step >= correct_order.size():
		puzzle_finished = true
		print("puzzle uz hotovy")
		return

	if flower_id == correct_order[current_step]:
		print("spravne")
		var flower = get_flower_by_id(flower_id)
		if flower != null:
			flower.play_correct()
		current_step += 1

		if current_step >= correct_order.size():
			puzzle_finished = true
			print("HOTOVO")
			puzzle_done()
	else:
		print("spatne")
		reset_puzzle()

func get_flower_by_id(flower_id):
	match flower_id:
		1: return kytka1
		2: return kytka2
		3: return kytka3
		4: return kytka4
	return null

func reset_puzzle():
	if puzzle_finished:
		return

	current_step = 0
	kytka1.set_default()
	kytka2.set_default()
	kytka3.set_default()
	kytka4.set_default()

func puzzle_done():
	print("PUZZLE SPLNEN")
	if zamek1 != null:
		zamek1.visible = false
