class_name Player

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _init() -> void:
	return

func _process(delta: float) -> void:
	
	return

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

	move_and_slide()
