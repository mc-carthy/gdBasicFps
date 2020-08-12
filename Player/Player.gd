extends KinematicBody

export var speed: float = 10
export var acceleration: float = 5
export var gravity: float = -2.8
export var jump_speed: float = 30
export var mouse_sensitivity: float = 0.3

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera

var velocity := Vector3()
var camera_vert: float = 0
var camera_vert_limit: float = deg2rad(60)
var is_jumping: bool = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var vert_delta = deg2rad(-event.relative.y * mouse_sensitivity)
		camera_vert = clamp(camera_vert + vert_delta, -camera_vert_limit, camera_vert_limit)
		camera.rotation.x = camera_vert

func _process(delta: float) -> void:
	is_jumping = true if Input.is_action_just_pressed('jump') else false

func _physics_process(delta: float) -> void:
	var head_basis: Basis = head.global_transform.basis
	var direction := Vector3()
	
	if Input.is_action_pressed('move_forward'):
		direction -= head_basis.z
	if Input.is_action_pressed('move_backward'):
		direction += head_basis.z
	if Input.is_action_pressed('move_left'):
		direction -= head_basis.x
	if Input.is_action_pressed('move_right'):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y += gravity
	
	if is_jumping and is_on_floor():
		velocity.y += jump_speed
	
	velocity = move_and_slide(velocity, Vector3.UP)
