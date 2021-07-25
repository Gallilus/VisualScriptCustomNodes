tool
extends VisualScriptCustomNode

enum _error_conditions {if_true, if_false, is_not_valid}
export (_error_conditions) var error_condition := 0 setget _set_error_condition
func _set_error_condition(value):
	error_condition = value
	ports_changed_notify()

enum _reactions {_breakpoint, _print, _print_debug, _print_error, _dont_print}
export (_reactions) var reaction := 0 setget _set_reaction
func _set_reaction(value):
	reaction = value
	ports_changed_notify()
	#property_list_changed_notify()

export (int, 1, 10) var input_count := 1 setget _set_input_count
func _set_input_count(value):
	input_count = value
	ports_changed_notify()

export (String) var print_string := ""

func _get_category():
	return "flow_control"

func _get_caption():
	return "check error"

func _has_input_sequence_port():
	return true

func _get_text():
	return _error_conditions.keys()[error_condition]

func _get_output_sequence_port_count():
	return 3

func _get_output_sequence_port_text(idx):
	match idx:
		0:
			return "error"
		1:
			return "ok"
		2:
			return "done"

func _get_input_value_port_count():
	return input_count

func _get_input_value_port_name(idx):
	if idx == 0:
		if error_condition < 2:
			return "bool"
		else:
			return "instance"
	return "%s "# + str(idx-1)

func _get_input_value_port_type(idx):
	if idx == 0:
		if error_condition < 2:
			return TYPE_BOOL
		else:
			return TYPE_OBJECT

#input hint(_string example text)

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(idx):
	return "error_str"

func _get_output_value_port_type(idx):
	return TYPE_STRING

func _step(inputs, outputs, start_mode, working_mem):
	if not start_mode == START_MODE_BEGIN_SEQUENCE:
		return 2
	
	var condition = inputs.pop_front()
	
	match error_condition:
		0:
			if condition:
				print(inputs)
				outputs[0] = print_string.format(inputs,"%s")
		1:
			if not condition:
				outputs[0] = print_string.format(inputs,"%s")
		2:
			if not is_instance_valid(condition):
				outputs[0] = print_string.format(inputs,"%s")
	
	if outputs[0]:
		match reaction:
			0:
				printerr(outputs[0])
				return outputs[0]
			1:
				print(outputs[0])
			2:
				print_debug(outputs[0])
			3:
				printerr(outputs[0])
			_:
				pass
		return 0 | STEP_PUSH_STACK_BIT
	else:
		return 1 | STEP_PUSH_STACK_BIT


