extends CharacterBody3D

@export var inventory_data: InventoryData

@export var speed = 5.0          # kecepatan jalan biasa
@export var sprint_speed = 9.0   # kecepatan lari (bisa kamu ubah di Inspector)
@export var jump_velocity = 4.5
@export var mouse_sensitivity = 0.002
@export var turn_speed = 10.0

signal toggle_inventory()

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		$SpringArm3D.rotation.y -= event.relative.x * mouse_sensitivity
		$SpringArm3D.rotation.x -= event.relative.y * mouse_sensitivity
		$SpringArm3D.rotation.x = clamp($SpringArm3D.rotation.x, -PI/2 + 0.1, PI/2 - 0.1)
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory.emit()

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# === MOVEMENT + SPRINT ===
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var cam = $SpringArm3D/Camera3D
	var forward = -cam.global_transform.basis.z
	var right   = cam.global_transform.basis.x
	var direction = (forward * -input_dir.y + right * input_dir.x).normalized()

	# Cek apakah Shift ditekan
	var current_speed = sprint_speed if Input.is_action_pressed("sprint") else speed

	if direction.length() > 0.1:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		
		# Player menghadap ke arah gerakan (smooth)
		var target_angle = atan2(direction.x, direction.z)
		$Pivot.rotation.y = lerp_angle($Pivot.rotation.y, target_angle, delta * turn_speed)
		
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()

	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
