tool
extends VisualScriptCustomNode

# https://en.wikipedia.org/wiki/Escape_sequences_in_C
var constants := ["\n", "\t", "'", '"', "\\", "\b", "\f", "\r", "\v", "\a" ]
var constants_print := ["\\n", "\\t", "\'", '\"', "\\\\", "\\b", "\\f", "\\r", "\\v", "\\a" ]

#enum constant_names {NEW_LINE, HORIZONTAL_TAB, APOSTROPHE, QUOTATION_MARK, BACKSLASH, BACKSPACE, PAGE_BREAK, RETRUN, VERTICAL_TAB, BEL}
enum constant_names {NEW_LINE, H_TAB, APOSTROPHE, Q_MARK, BACKSLASH, BACKSPACE, PAGE_BREAK, RETRUN, V_TAB, BEL}
var _constant_names := 0
export (constant_names) var constant_name : int setget set_constant_name, get_constant_name
func get_constant_name():
	return _constant_names
func set_constant_name(value):
	if not value == _constant_names:
		_constant_names = value
		ports_changed_notify()

func _get_category():
	return "data"

func _get_caption():
	return constant_names.keys()[_constant_names]

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(idx):
	return constants_print[_constant_names]

func _get_output_value_port_type(_idx):
	return TYPE_STRING

func _step(_inputs, outputs, _start_mode, _working_mem):
	outputs[0] = constants[_constant_names]
	return 0
