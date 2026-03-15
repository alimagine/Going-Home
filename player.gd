extends CharacterBody3D

@export var speed = 5.0
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.002

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		$SpringArm3D.rotation.x -= event.relative.y * mouse_sensitivity
		$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x, -PI/2 + 0.1, PI/2 - 0.1)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# TEST PAKAI ui_ (pasti ada di Godot)
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	print("INPUT DETECTED: ", input_dir)

	var direction = (transform.basis * Vector3(input_dir.x, 0, -input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
