class_name BeemEmitter
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed:
			if Input.is_action_just_pressed("test_a"):
				rotate(0.1);
			if Input.is_action_just_pressed("test_b"):
				rotate(-0.1);;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if($RayCast.is_colliding()):
		var collider: CollisionObject2D = $RayCast.get_collider()
		if(collider.get_collision_layer_value(4)):
			var light_collider: AbstractLightHandler = collider
			light_collider._handle_light_collision(global_position, self)
		var collision_loc: Vector2 = $RayCast.get_collision_point()
		var distance = position.distance_to(collision_loc)
		if($Beam.get_current_length() == distance):
			return
		$Beam.set_current_length(distance)
