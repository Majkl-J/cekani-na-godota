class_name Player

extends CharacterBody2D

# Track the last motion
var last_motion = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var use_mouse_flashlight_aim: bool = true
@export var flashlight_rotate_speed: float = 2.5
@export var flashlight_enabled: bool = false
@onready var flashlight_pivot: Node2D = $FlashlightPivot
@onready var flashlight: PointLight2D = $FlashlightPivot/Flashlight

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# Nápověda
@onready var left_hint = $HintContainer/LeftHint
@onready var right_hint = $HintContainer/RightHint
@onready var jump_hint = $HintContainer/JumpHint

var is_in_space = false

func _ready() -> void:
	# Fuck you, no time. Hardcoding :333
	var current_room: Scene = $"/root/controller".get_main_node()
	is_in_space = current_room.get_meta("room_id") == 3
	flashlight.visible = flashlight_enabled
	# Nápověda
	if left_hint != null:
		left_hint.visible = not $"/root/controller".used_left_hint
	if right_hint != null:
		right_hint.visible = not $"/root/controller".used_right_hint
	if jump_hint != null:
		jump_hint.visible = not $"/root/controller".used_jump_hint

func _process(delta: float) -> void:
	# Pro nápovědu na začátku hry, pak už nee
	if Input.is_action_just_pressed("ui_left"):
		if left_hint != null:
			left_hint.visible = false
		$"/root/controller".used_left_hint = true
	if Input.is_action_just_pressed("ui_right"):
		if right_hint != null:
			right_hint.visible = false
		$"/root/controller".used_right_hint = true
	if Input.is_action_just_pressed("ui_accept"):
		if jump_hint != null:
			jump_hint.visible = false
		$"/root/controller".used_jump_hint = true
	update_flashlight(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if not event.pressed:
			return
		if Input.is_action_just_pressed("open"):
			tryOpenDoor();
	
	if event.is_action_pressed("flashlight_toggle"):
		flashlight_enabled = !flashlight_enabled
		flashlight.visible = flashlight_enabled

func tryOpenDoor():
	for hit: Node2D in $Interaction.get_overlapping_bodies():
		if not hit is Door:
			continue
		var door: Door = hit
		door.passThrough(self)
	return

func _physics_process(delta: float) -> void:
	if(not is_in_space):
		default_phys(delta)
	else:
		space_phys(delta)

	var direction := Input.get_axis("ui_left", "ui_right")
	update_animation(direction)
	move_and_slide()

func default_phys(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

# No documentation. Figure it out~ :3c
func space_phys(delta: float):
	var slowdown = SPEED * 0.3
	var accell = SPEED * 0.6
	# Lazyyyy qwq
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	if direction_x:
		velocity.x = move_toward(velocity.x, SPEED * direction_x, accell * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, slowdown * delta)
	if direction_y:
		velocity.y = move_toward(velocity.y, SPEED * direction_y, accell * delta)
	else:
		velocity.y = move_toward(velocity.y, 0, slowdown * delta)
	return

# Function to update the character's animation based on state
func update_animation(direction: float) -> void:
	if direction != 0:
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("stand")
	# otočení postavičky
	if direction > 0:
		animated_sprite_2d.flip_h = true
	elif direction < 0:
		animated_sprite_2d.flip_h = false

func update_flashlight(delta: float) -> void:
	if not flashlight_enabled:
		return

	if use_mouse_flashlight_aim:
		var mouse_pos: Vector2 = get_global_mouse_position()
		var dir: Vector2 = mouse_pos - global_position
		flashlight_pivot.rotation = dir.angle()
	else:
		var rotate_dir := 0.0

		if Input.is_action_pressed("flashlight_left"):
			rotate_dir -= 1.0
		if Input.is_action_pressed("flashlight_right"):
			rotate_dir += 1.0

		flashlight_pivot.rotation += rotate_dir * flashlight_rotate_speed * delta

func check_motion_flip() -> void:
	if last_motion.x < 0:
		# If moving left, flip the sprite horizontally
		animated_sprite_2d.flip_h = true
	elif last_motion.x > 0:
		# If moving right, reset to the default flip
		animated_sprite_2d.flip_h = false
