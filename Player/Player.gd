extends KinematicBody

export var speed: float = 10
export var acceleration: float = 5
export var gravity: float = -9.8
export var jump_speed: float = 30

onready var head: Spatial = $Head
onready var camera: Camera = $Head/Camera

var velocity := Vector3()

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
	
	velocity = move_and_slide(velocity)
