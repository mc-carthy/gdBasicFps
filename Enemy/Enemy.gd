extends KinematicBody

var target: Spatial

func _process(delta: float) -> void:
	if target:
		look_at(target.global_transform.origin, Vector3.UP)

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
