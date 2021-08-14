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

func _get_category():
#	return "data"
#	return "functions"
#	return "operators"
#	return "flow_control"
#	return "constants"
	return "Custom"

func _get_caption():
	return "times run?"

func _get_output_value_port_count():
	return 2

func _get_output_value_port_name(_idx):
	if _idx == 0:
		return "times run"
	return "times run abs"

func _get_output_value_port_type(_idx):
	return TYPE_INT

func _get_working_memory_size():
	return 1

var w_mem_abs := 0

func _step(_inputs, outputs, _start_mode, working_mem):
	
	if working_mem[0]:
		working_mem[0] += 1
	else:
		working_mem[0] = 1
	
	w_mem_abs += 1
	
	outputs[0] = working_mem[0]
	outputs[1] = w_mem_abs
	
	return 0
