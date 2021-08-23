tool
extends VisualScriptCustomNode

export (int, "breakpoint", "print", "print_debug", "print_error", "dont_print") var reaction := 0 setget _set_reaction
func _set_reaction(value):
	reaction = value
	ports_changed_notify()

export (int, 1, 10) var input_count := 1 setget _set_input_count
func _set_input_count(value):
	input_count = value
	ports_changed_notify()

export (String) var print_string := ""

func _get_category():
	return "functions"

func _get_caption():
	return "Print Format"

func _has_input_sequence_port():
	return true

func _get_output_sequence_port_count():
	return 2

func _get_output_sequence_port_text(idx):
	match idx:
		0:
			return "ok"
	return "done"

func _get_input_value_port_count():
	return input_count

func _get_input_value_port_name(_idx):
	return "%s"

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(_idx):
	return "error_str"

func _get_output_value_port_type(_idx):
	return TYPE_STRING

func _get_working_memory_size():
	return 1

func _step(inputs, outputs, start_mode, working_mem):
	if not start_mode == START_MODE_BEGIN_SEQUENCE:
		outputs[0] = working_mem[0]
		return 1
	
	outputs[0] = print_string.format(inputs,"%s")
	
	working_mem[0] = outputs[0]
	
	match reaction:
		0:
			printerr(outputs[0])
			return "breakpoint reached: " + outputs[0]
		1:
			print(outputs[0])
		2:
			print_debug(outputs[0])
		3:
			printerr(outputs[0])
		_:
			pass
	return 0 | STEP_PUSH_STACK_BIT
