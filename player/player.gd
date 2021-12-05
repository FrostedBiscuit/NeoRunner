extends KinematicBody

const MOUSE_SENSITIVITY = 0.225

onready var camera = $CameraBase
onready var weapon_handler = $CameraBase/CameraBoom/Weapons
onready var pause_menu = $PauseMenu

# Movement values
var velocity = Vector3.ZERO
var current_vel = Vector3.ZERO
var dir = Vector3.ZERO

const SPEED = 10
const SPRINT_SPEED = 20
const ACCELERATION = 15

const GRAVITY = -9.81 * 4
const JUMP_SPEED = 10
const AIR_ACCELERATION = 9
var jump_counter = 0

func _ready():
	# Register player with WeaponManager
	_regsiter_player()

	# Lock mouse to center of screen/window
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	_process_weapon_input()

func _physics_process(delta):
	_process_movement_input(delta)

func _input(event):
	if event is InputEventMouseMotion:
		_process_mouse_movement(event)

	# If ESC is pressed, show/hide pause menu
	if Input.is_action_just_pressed("ui_cancel"):
		_handle_pause_menu()
	

# Contains all functionality related to looking around
func _process_mouse_movement(event):

	# Exit if mouse is not locked
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	# Rotate camera vertically
	$CameraBase/CameraBoom.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	$CameraBase/CameraBoom.rotation_degrees.x = clamp($CameraBase/CameraBoom.rotation_degrees.x, -90, 90)

	#Rotate player horizontally
	self.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))

func _process_movement_input(delta):
	dir = Vector3.ZERO

	# Gather input info
	var z_input = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	var x_input = Input.get_action_strength("right") - Input.get_action_strength("left")

	dir += camera.global_transform.basis.z * z_input
	dir += camera.global_transform.basis.x * x_input

	# print("Current direction: %s" % str(dir))

	if dir.length() > 1:
		dir = dir.normalized()

	# Apply gravity
	velocity.y += GRAVITY * delta

	if is_on_floor():
		jump_counter = 0

	# Handle jumping
	if Input.is_action_just_pressed("jump") and jump_counter < 1:
		jump_counter += 1
		velocity.y = JUMP_SPEED

	# Handle sprinting
	var speed = SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED
	var target_vel = dir * speed

	# Handle smoothing movement
	var acceleration = ACCELERATION if is_on_floor() else AIR_ACCELERATION
	current_vel = current_vel.linear_interpolate(target_vel, acceleration * delta)

	# Move player
	velocity.x = current_vel.x
	velocity.z = current_vel.z
	velocity = move_and_slide(velocity, Vector3.UP, true, 4, deg2rad(45))

# Handles pause menu
func _handle_pause_menu():
	# Change mouse mode depending on current state
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		_show_pause_menu()
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		_hide_pause_menu()

# Handles all weapon related input (firing/reloading)
func _process_weapon_input():
	if Input.is_action_pressed("fire"):
		weapon_handler.attack()
	elif Input.is_action_just_released("fire"):
		weapon_handler.stop_attacking()

	if Input.is_action_pressed("reload"):
		weapon_handler.reload()

# Register player instance and weapon handler with WeaponManager
func _regsiter_player():
	WeaponManager.player = self
	WeaponManager.player_weapon_handler = weapon_handler

func _show_pause_menu():
	pause_menu.show()
	set_process(false)
	set_physics_process(false)

func _hide_pause_menu():
	pause_menu.hide()
	set_process(true)
	set_physics_process(true)