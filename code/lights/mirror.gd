class_name Mirror extends AbstractLightHandler

func vec_magnitude(v: Vector2) -> float:
	return sqrt(v.x * v.x + v.y * v.y)

var mirror_off = preload("res://icons/light/mirror_dim.png")
var mirror_on = preload("res://icons/light/mirror_lit.png")

var reflecting: bool = false
var hit_reflect: bool = true

func get_reflecting():
	return reflecting

func set_reflecting(new_value: bool):
	if(new_value):
		$Sprite2D.texture = mirror_on
	else:
		$Sprite2D.texture = mirror_off

func _handle_light_collision(light_origin: Vector2, _light_source: BeemEmitter) -> void:
	hit_reflect = true
	var origin_relative = light_origin - global_position
	var normal = -$Normal.global_position - global_position
	var origin_len = vec_magnitude(origin_relative)
	var cos_value = normal.dot(origin_relative)/origin_len
	var angle = acos(cos_value)
	set_reflecting(true)
	add_emitter(angle, _light_source)
	return

func _process(delta: float) -> void:
	if(hit_reflect == false):
		set_reflecting(false)
		remove_emitters()
	hit_reflect = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if Input.is_action_just_pressed("test_a"):
				rotate(0.1);
			if Input.is_action_just_pressed("test_b"):
				rotate(-0.1);;
	
