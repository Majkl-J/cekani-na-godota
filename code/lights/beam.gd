class_name Beem
extends Node2D

func kill_all_beems():
	for beem in get_children():
		remove_child(beem)
		beem.free()

var current_length: float = 270
func set_current_length(new_length: float = 0):
	set_length(new_length)
	current_length = new_length
func get_current_length():
	return current_length

# Look at this disgusting thing
func set_length(set_len: float):
	var beam_polys = get_children()
	var default_beem: Resource = $"/root/controller".get_beem_resource()
	var max_len: float = $"/root/controller".get_max_len()
	if set_len <= 0:
		kill_all_beems()
		return
	
	# Populate beem
	if len(beam_polys) <= 0:
		var beem_x = 0
		while(set_len >= max_len):
			summon_beem(default_beem, max_len, beem_x)
			beem_x += max_len
			set_len -= max_len
		summon_beem(default_beem, set_len, beem_x)
		return
	# Adjust beem
	var beem_count = ceil(set_len / max_len)
	# :33333333333333 This is trash
	var hit_pos = -1
	for i in range(max(beem_count, len(beam_polys))):
		var b: BeemPoly
		if hit_pos != -1:
			b = get_child(hit_pos)
		else:
			b = get_child(i)
		if(b == null && i+1 <= beem_count):
			if(i+1 == beem_count):
				summon_beem(default_beem, fmod(set_len, max_len), max_len * i+1)
			else:
				summon_beem(default_beem, max_len, max_len * i+1)
			continue
		if(i >= beem_count):
			if hit_pos == -1:
				hit_pos = i
			remove_child(b)
			b.queue_free()
			continue
		var stupid_fucking_check = fmod(set_len, max_len)
		if(i+1 == beem_count && stupid_fucking_check < max_len && stupid_fucking_check != 0):
			b.set_length(fmod(set_len, max_len))
			continue
		b.set_length(max_len)
	return

func summon_beem(beem_res: Resource, beem_len: float, x_shift: float = 0):
	var beem: BeemPoly = beem_res.instantiate()
	add_child(beem)
	beem.set_length(beem_len)
	beem.position.x = x_shift
