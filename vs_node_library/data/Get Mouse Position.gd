tool
extends VisualScriptCustomNode

export var sequenced := false setget set_sequenced
func set_sequenced(value):
	sequenced = value
	ports_changed_notify()
func _has_input_sequence_port():
	return sequenced
func _get_output_sequence_port_count():
	return 0 + int(sequenced)

enum _relatives {global, local, viewport}
export (_relatives) var relative := 0 setget set_relative
func set_relative(value):
	if not value == relative:
		relative = value
		ports_changed_notify()


func _get_category():
	return "data"

func _get_caption():
	return "Get Mouse Position"

func _get_input_value_port_count():
	return 1

func _get_input_value_port_name(idx):
	return "self"

func _get_input_value_port_type(idx):
	TYPE_OBJECT

func _get_input_value_port_hint(idx):
	return PROPERTY_HINT_RESOURCE_TYPE

func _get_input_value_port_hint_string(idx):
	return "Node"

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(idx):
	match relative:
		0:
			return "glob_pos"
		1:
			return "local_pos"
		2:
			return "view_pos"

func _get_output_value_port_type(idx):
	return TYPE_VECTOR2


func _step(inputs, outputs, start_mode, working_mem):
	if !inputs[0]:
		return "Input[0] not connected to self"
	
	match relative:
		0:
			if inputs[0].has_method("get_global_mouse_position"):
				outputs[0] = inputs[0].get_global_mouse_position()
		1:
			if inputs[0].has_method("get_local_mouse_position"):
				outputs[0] = inputs[0].get_local_mouse_position()
		2:
			if inputs[0].has_method("get_mouse_position"):
				outputs[0] = inputs[0].get_mouse_position()
			if inputs[0].has_method("get_viewport"):
				outputs[0] = inputs[0].get_viewport().get_mouse_position()
	
	return 0
