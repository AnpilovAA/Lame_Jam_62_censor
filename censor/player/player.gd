extends CharacterBody3D

var SPEED = 2
var fall_acceleration = 75
var target_velocity = Vector3()
var mouse_sensetive = 0.005

#func _process(delta: float) -> void:
	#Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Вот тут нормальная камера по движению мыши. осталось ограничить
		rotation.y -= event.relative.x * mouse_sensetive
		rotation.x += -event.relative.y * mouse_sensetive
	pass

func _physics_process(delta: float) -> void:
	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		#$Pivot.basis = Basis.looking_at(direction)

	target_velocity.x = direction.x * SPEED
	target_velocity.z = direction.z * SPEED
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
	velocity = target_velocity
	move_and_slide()
