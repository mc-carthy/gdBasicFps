extends Node

export var fire_rate: float = 0.5
export var clip_size: int = 5
export var reload_speed: float = 1

onready var raycast: RayCast = $'../Head/Camera/RayCast'

var current_ammo: int = clip_size
var can_fire: bool = true
var is_reloading: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed('fire_primary') and can_fire:
		fire()

func fire() -> void:
	if not is_reloading:
		if current_ammo > 0:
			can_fire = false
			current_ammo -= 1
			check_collision()
			yield(get_tree().create_timer(fire_rate), 'timeout')
			can_fire = true
		else:
			is_reloading = true
			yield(get_tree().create_timer(reload_speed), 'timeout')
			is_reloading = false
			current_ammo = clip_size

func check_collision() -> void:
	if raycast.is_colliding():
		var collider: Object = raycast.get_collider()
		if collider.is_in_group('Enemies'):
			collider.queue_free()
