tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"string","type":TYPE_STRING},
			{"name":"string", "value":"test"},
			{"name":"string_FILE", "value":"test", "hint":PROPERTY_HINT_FILE, "hint_string":"*.gd"},
			{"name":"string_DIR", "value":"test", "hint":PROPERTY_HINT_DIR},
			{"name":"string_GLOBAL_FILE (tool only)", "value":"test", "hint":PROPERTY_HINT_GLOBAL_FILE, "hint_string":"*.gd"},
			{"name":"string_GLOBAL_DIR (tool only)", "value":"test", "hint":PROPERTY_HINT_GLOBAL_DIR},
			{"name":"string_MULTILINE_TEXT_NOT", "value":"try enter or special characters lik \\t"},
			{"name":"string_MULTILINE_TEXT", "value":"try enter or special characters lik \\t", "hint":PROPERTY_HINT_MULTILINE_TEXT},
			{"name":"string_PLACEHOLDER_TEXT", "type":TYPE_STRING, "hint":PROPERTY_HINT_PLACEHOLDER_TEXT, "hint_string":"try save before pressing file clear"},
			]

func _custom_function(_a,_b,_c,_d,_e,_f,_g,_h,_i):
	pass
