extends KinematicBody

var target: Spatial
var space_state: PhysicsDirectSpaceState

func _ready() -> void:
	space_state = get_world().direct_space_state

func _process(delta: float) -> void:
	if target:
		var result = space_state.intersect_ray(global_transform.origin, target.global_transform.origin)
		if result.collider.is_in_group('Player'):
			look_at(target.global_transform.origin, Vector3.UP)
			set_colour_red()
		else:
			set_colour_green()

func _on_Area_body_entered(body: Node) -> void:
	print(body.name + " entered")
	if body.is_in_group('Player'):
		target = body
		set_colour_red()


func _on_Area_body_exited(body: Node) -> void:
	print(body.name + " exited")
	if body.is_in_group('Player'):
		target = null
		set_colour_green()

func set_colour_red() -> void:
	$MeshInstance.get_surface_material(0).set_albedo(Color(1, 0, 0))

func set_colour_green() -> void:
	$MeshInstance.get_surface_material(0).set_albedo(Color(0, 1, 0))
