tool
extends VisualScriptCustomNode

#export var sequenced := false setget set_sequenced
#func set_sequenced(value):
#	if not sequenced == value:
#		sequenced = value
#		ports_changed_notify()
#func _has_input_sequence_port():
#	return sequenced
#func _get_output_sequence_port_count():
#	return 0 + int(sequenced)

func _get_category():
#	return "data"
#	return "functions"
#	return "operators"
#	return "flow_control"
#	return "constants"
	return "Custom"

func _get_caption():
	return "caption"

func _has_input_sequence_port():
	return true

func _get_text():
	return "text"


func _get_output_sequence_port_count():
	return 2

func _get_output_sequence_port_text(idx):
	match idx:
		0:
			return "first"
		1:
			return "second"


func _get_input_value_port_count():
	return 2

func _get_input_value_port_hint(idx):
	# export(String, FILE, "*.txt")
	# export(int, -10, 20)
	match idx:
		0:
			return PROPERTY_HINT_FILE
		1:
			return PROPERTY_HINT_RANGE

func _get_input_value_port_hint_string(idx):
	# export(String, FILE, "*.txt")
	# export(int, -10, 20)
	match idx:
		0:
			return "*.txt"
		1:
			return "-10, 20"

func _get_input_value_port_name(idx):
	match idx:
		0:
			return "file"
		1:
			return "number"

func _get_input_value_port_type(idx):
	match idx:
		0:
			return TYPE_STRING
		1:
			return TYPE_INT


func _get_output_value_port_count():
	return 2

func _get_output_value_port_hint(idx):
	if idx == 0:
			return PROPERTY_HINT_RESOURCE_TYPE

func _get_output_value_port_hint_string(idx):
	if idx == 0:
			return "RigidBody"

func _get_output_value_port_name(idx):
	match idx:
		0:
			return "some RigidBody"
		1:
			return "amount"

func _get_output_value_port_type(idx):
	match idx:
		0:
			return TYPE_OBJECT
		1:
			return TYPE_INT

func _step(_inputs, outputs, start_mode, _working_mem):
	if not start_mode == START_MODE_BEGIN_SEQUENCE:
		return 1
	
	# do some logic
	
	outputs[0] = RigidBody.new()
	outputs[1] = 10
	
	return 0
