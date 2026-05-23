extends CharacterBody3D
var SPEED = 20
var fall_acceleration = 75
var target_velocity = Vector3.ZERO


func _unhandled_input(event: InputEvent) -> void:
	var velocity = Vector3.ZERO
	if event is InputEventMouseMotion:
		print(event)
		$Pivot/tipsya.rotate_y(float(event.relative.x))
	pass

func _physics_process(delta: float) -> void:
	var velocity = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		velocity.z -= 1
	if Input.is_action_pressed("move_back"):
		velocity.z += 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if velocity != Vector3.ZERO:
		velocity = velocity.normalized()
		$Pivot.basis = Basis.looking_at(velocity)
	target_velocity = velocity.x * SPEED
	target_velocity = velocity.z * SPEED
	velocity = target_velocity
	move_and_slide()
