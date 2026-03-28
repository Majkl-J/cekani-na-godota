class_name BeamSplitter extends AbstractLightHandler


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Emitter1.toggled = false
	$Emitter2.toggled = false
	$Emitter1.add_exception(self)
	$Emitter2.add_exception(self)

var splitter_off = preload("res://icons/light/splitter_off.png")
var splitter_on = preload("res://icons/light/splitter_on.png")

var hit: bool = false
var splitting: bool = false
const ROTATE_RATE = 29

func get_splitting():
	return splitting

func set_splitting(new_value: bool):
	if(new_value):
		$Sprite2D.texture = splitter_on
	else:
		$Sprite2D.texture = splitter_off
		$Emitter1.toggled = false
		$Emitter2.toggled = false
	splitting = new_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(hit):
		set_splitting(true)
	else:
		set_splitting(false)
	hit = false
	if Input.is_action_pressed("mirror_left"):
		tryRotateSplitter(-1, 1, delta)
	if Input.is_action_pressed("mirror_right"):
		tryRotateSplitter(1, 1, delta)
	if Input.is_action_pressed("secondary_left"):
		tryRotateSplitter(-1, 2, delta)
	if Input.is_action_pressed("secondary_right"):
		tryRotateSplitter(1, 2, delta)

func _handle_light_collision(light_source: BeemEmitter, hit_pos: Vector2) -> void:
	if(hit):
		return
	$Emitter1.toggled = true
	$Emitter2.toggled = true
	hit = true

func tryRotateSplitter(dir: int, emitter_id: int, delta: float):
	for hit: Node2D in $CollisonInteraction.get_overlapping_bodies():
		if not hit is Player:
			continue
		var chosen_emitter: BeemEmitter = $Emitter1
		if(emitter_id == 2):
			chosen_emitter = $Emitter2
		chosen_emitter.rotation_degrees = clampf(chosen_emitter.rotation_degrees + (dir * ROTATE_RATE * delta), -90, 90)
	return
