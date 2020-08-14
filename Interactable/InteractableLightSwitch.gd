extends Interactable

export var light_node_path := NodePath()
export var on_by_default: bool = true
export var on_energy: float = 1.0
export var off_energy: float = 0.0

onready var light_node: Light = get_node(light_node_path)
onready var on: bool = on_by_default

func _ready() -> void:
	set_light_energy()

func set_light_energy() -> void:
	light_node.set_param(Light.PARAM_ENERGY, on_energy if on else off_energy)

func get_interaction_text() -> String:
	return "Switch light off" if on else "Switch light on"

func interact() -> void:
	on = !on
	set_light_energy()
