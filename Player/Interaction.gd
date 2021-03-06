extends RayCast

onready var interaction_label: Label = $'/root/World/UI/InteractionLabel'
onready var interact_key: String = OS.get_scancode_string(InputMap.get_action_list('interact')[0].scancode)
var current_collider

func _ready() -> void:
	set_interaction_text('')

func _process(delta: float) -> void:
	var collider: Object = get_collider()
	if is_colliding() and collider is Interactable:
		if current_collider != collider:
			current_collider = collider
			set_interaction_text(collider.get_interaction_text())
		
		if Input.is_action_just_pressed('interact'):
			collider.interact()
			set_interaction_text(collider.get_interaction_text())
	elif current_collider:
		current_collider = null
		set_interaction_text('')
func set_interaction_text(text: String) -> void:
	if text:
		interaction_label.set_text('Press %s to %s' % [interact_key, text])
		interaction_label.set_visible(true)
	else:
		interaction_label.set_text('')
		interaction_label.set_visible(false)
