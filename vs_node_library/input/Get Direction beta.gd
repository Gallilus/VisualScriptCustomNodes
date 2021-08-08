tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"relative_to", "type":TYPE_OBJECT, "hint":PROPERTY_HINT_RESOURCE_TYPE, "hint_string":"Spatial"},
			{"name":"force_right", "value": 0.0, "hint":PROPERTY_HINT_RANGE, "hint_string":"0, 1, 0.001"},
			{"name":"force_left", "value": 0.0, "hint":PROPERTY_HINT_RANGE, "hint_string":"0, 1, 0.001"},
			{"name":"force_back", "value": 0.0, "hint":PROPERTY_HINT_RANGE, "hint_string":"0, 1, 0.001"},
			{"name":"force_forward", "value": 0.0, "hint":PROPERTY_HINT_RANGE, "hint_string":"0, 1, 0.001"},
			]
	_output_clues = [{"name":"dir"}]

func _custom_function(follower, force_right, force_left, force_back, force_forward)->Vector3:
	
	var dir = Vector3()
	dir.x = force_right - force_left
	dir.z = force_back - force_forward

	# Get the camera's t"res://addons/VisualScriptCustomNodes/CustomNodes/get_direction.gd"ransform basis, but remove the X rotation such
	# that the Y axis is up and Z is horizontal.
	var cam_basis = follower.global_transform.basis
	var basis = cam_basis.rotated(cam_basis.x, -cam_basis.get_euler().x)
	dir = basis.xform(dir)

	# Limit the input to a length of 1. length_squared is faster to check.
	if dir.length_squared() > 1:
		dir /= dir.length()

	return dir
