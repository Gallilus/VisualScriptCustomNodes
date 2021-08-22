tool
extends VisualScriptCustomNode
class_name VisualScriptConstantFunc

export var sequenced := false setget set_sequenced
func set_sequenced(value):
	if not sequenced == value:
		sequenced = value
		ports_changed_notify()
func _has_input_sequence_port():
	return sequenced
func _get_output_sequence_port_count():
	return 0 + int(sequenced)

var _return

func _get_caption():
	_return = self.callv("_constant_function", [])
	return self.get_script().get_path().get_file().get_basename()

func _get_category():
	return "custom"

func _get_output_value_port_count():
	return 1

func _get_output_value_port_hint(_idx):
	if typeof(_return) == TYPE_OBJECT:
		return PROPERTY_HINT_RESOURCE_TYPE

func _get_output_value_port_hint_string(_idx):
	if typeof(_return) == TYPE_OBJECT:
		return _return.get_class()
	return ""

func _get_output_value_port_name(_idx):
	return " "

func _get_output_value_port_type(_idx):
	return typeof(_return)

func _step(_inputs, outputs, _start_mode, _working_mem):
	outputs[0] = self.callv("_constant_function", [])
	return 0
