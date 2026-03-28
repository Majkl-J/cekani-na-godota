class_name Mirror extends AbstractLightHandler

func vec_magnitude(v: Vector2) -> float:
	return sqrt(v.x * v.x + v.y * v.y)

var mirror_off = preload("res://icons/light/mirror_dim.png")
var mirror_on = preload("res://icons/light/mirror_lit.png")

var reflecting: bool = false
var hit_reflect: bool = true
const ROTATE_RATE = 29

func get_reflecting():
	return reflecting

func set_reflecting(new_value: bool):
	if(new_value):
		$Sprite2D.texture = mirror_on
	else:
		$Sprite2D.texture = mirror_off

func _handle_light_collision(light_source: BeemEmitter, hit_pos: Vector2) -> void:
	hit_reflect = true
	var source_direction = Vector2(0,0).direction_to(light_source.global_position - global_position)
	var normal = $Normal.global_position - global_position
	var cos_value = normal.dot(source_direction)
	# This was headache inducing but it fucking works
	# Dont even ask
	# I aint taking enough E for this shit, holy fuck :RALSEI_SMOKING_FAT_BLUNT:
	var awa = source_direction.rotated(-rotation)
	var angle_mult = 1
	if(awa.x >= 0):
		angle_mult = 1 if awa.y < 0 else -1
	else:
		angle_mult = -1 if awa.y < 0 else 1
	var angle = acos(cos_value) * angle_mult
	set_reflecting(true)
	add_emitter(angle, light_source, hit_pos)
	return

func _process(delta: float) -> void:
	if(hit_reflect == false):
		set_reflecting(false)
		remove_emitters()
	hit_reflect = false
	if Input.is_action_pressed("mirror_left"):
		tryRotateMirror(-1, delta)
	if Input.is_action_pressed("mirror_right"):
		tryRotateMirror(1, delta)

func tryRotateMirror(dir: int, delta: float):
	for hit: Node2D in $CollisonInteraction.get_overlapping_bodies():
		if not hit is Player:
			continue
		rotate_this_fuck(dir, delta)
	return

# This bitch is losing it awawaw :3
func rotate_this_fuck(dir: int, delta: float):
	rotation_degrees = clampf(rotation_degrees + (dir * ROTATE_RATE * delta), get_meta("lower_limit"), get_meta("upper_limit"))

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventKey:
		#if event.pressed:
			#if Input.is_action_just_pressed("test_a"):
				#rotate(0.1);
			#if Input.is_action_just_pressed("test_b"):
				#rotate(-0.1);;
	
