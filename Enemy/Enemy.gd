extends KinematicBody



func _on_Area_body_entered(body: Node) -> void:
	print(body.name + " entered")


func _on_Area_body_exited(body: Node) -> void:
	print(body.name + " exited")
