tool
extends VisualScriptCustomNode

export var steps := 1 setget _set_steps
func _set_steps(value):
	if not value == steps:
		if value < 1:
			value = 1
		steps = value
		ports_changed_notify()

func _get_category():
	return "flow_control"

func _get_caption():
	return "custom_sequence"

func _has_input_sequence_port():
	return true

func _get_text():
	return "in_order:"

func _get_output_sequence_port_count():
	return steps

func _get_output_sequence_port_text(idx):
	return "step %02d " %idx  + ":"

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(_idx):
	return "step nr"

func _get_output_value_port_type(_idx):
	return TYPE_INT


func _get_working_memory_size():
	return 1

func _step(_inputs, outputs, start_mode, working_mem):
	if start_mode == START_MODE_BEGIN_SEQUENCE:
		working_mem[0] = 0
	else:
		working_mem[0] += 1
	
	outputs[0] = working_mem[0] 
	
	if working_mem[0] < steps-1:
		return working_mem[0] | STEP_PUSH_STACK_BIT
	return steps-1
