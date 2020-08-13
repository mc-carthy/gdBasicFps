extends Weapon



func _ready() -> void:
	raycast.cast_to.z = -10
