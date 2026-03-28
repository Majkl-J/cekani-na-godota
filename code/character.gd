class_name Player

extends CharacterBody2D

# Track the last motion
var last_motion = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

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

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and Input.is_action_just_pressed("open"):
			tryOpenDoor();
	return

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
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

# No documentation. Figure it out~ :3c
func space_phys(delta: float):
	var slowdown = SPEED * 0.1
	var accell = SPEED * 0.2
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

func check_motion_flip() -> void:
	if last_motion.x < 0:
		# If moving left, flip the sprite horizontally
		animated_sprite_2d.flip_h = true
	elif last_motion.x > 0:
		# If moving right, reset to the default flip
		animated_sprite_2d.flip_h = false
