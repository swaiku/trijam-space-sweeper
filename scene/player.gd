extends CharacterBody2D


const SPEED = 5
const MAX_SPEED = 300
const ROTATION_SPEED = 250
const PUSH_FORCE = 50

func _physics_process(delta: float) -> void:

	var input_vector := Vector2(0, Input.get_axis("move_forward", "move_backward"))
	velocity += input_vector.rotated(rotation) * SPEED
	velocity += get_gravity()
	velocity = velocity.limit_length(MAX_SPEED)
	
	if Input.is_action_pressed("rotate_right"):
		rotate(deg_to_rad(ROTATION_SPEED*delta))
	if Input.is_action_pressed("rotate_left"):
		rotate(deg_to_rad(-ROTATION_SPEED*delta))
		
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_force(-c.get_normal() * PUSH_FORCE)
		
	move_and_slide()
