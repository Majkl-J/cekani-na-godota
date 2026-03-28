class_name Player

extends CharacterBody2D

# Track the last motion
var last_motion = Vector2.ZERO

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _init() -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and Input.is_action_just_pressed("open"):
			tryOpenDoor();
	return

func tryOpenDoor():
	for hit: Node2D in $Interaction_Door.get_overlapping_bodies():
		if not hit is Door:
			continue
		var door: Door = hit
		door.passThrough(self)
	return

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	update_animation(direction)
	move_and_slide()

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
