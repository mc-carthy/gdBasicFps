extends Spatial
class_name Weapon

export var fire_rate: float = 0.5
export var clip_size: int = 5
export var reload_speed: float = 1
export var raycast_path: NodePath
export var camera_path: NodePath
export var default_transform: Vector3
export var aim_transform: Vector3
export var default_fov: float = 70
export var aim_fov: float = 55
export var aim_time: float = 0.3

onready var raycast: RayCast = get_node(raycast_path)
onready var camera: Camera = get_node(camera_path)
onready var ammo_label: Label = $'/root/World/UI/Label'

var current_ammo: int = clip_size
var can_fire: bool = true
var is_reloading: bool = false

func _ready() -> void:
	ammo_label.set_text('Ammo: %d/%d' % [current_ammo, clip_size])

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('fire_primary') and can_fire:
		if not is_reloading:
			if current_ammo > 0:
				fire()
			else:
				reload()
	if Input.is_action_just_pressed('reload') and not is_reloading:
		reload()
	if Input.is_action_pressed("aim"):
		transform.origin = transform.origin.linear_interpolate(aim_transform, aim_time)
		camera.fov = lerp(camera.fov, aim_fov, aim_time)
	else:
		if transform.origin != default_transform:
			transform.origin = transform.origin.linear_interpolate(default_transform, aim_time)
			camera.fov = lerp(camera.fov, default_fov, aim_time)

func fire() -> void:
		can_fire = false
		current_ammo -= 1
		ammo_label.set_text('Ammo: %d/%d' % [current_ammo, clip_size])
		check_collision()
		yield(get_tree().create_timer(fire_rate), 'timeout')
		can_fire = true

func reload() -> void:
	is_reloading = true
	yield(get_tree().create_timer(reload_speed), 'timeout')
	is_reloading = false
	current_ammo = clip_size
	ammo_label.set_text('Ammo: %d/%d' % [current_ammo, clip_size])

func check_collision() -> void:
	if raycast.is_colliding():
		var collider: Object = raycast.get_collider()
		if collider.is_in_group('Enemies'):
			collider.queue_free()
