tool
extends VisualScriptCustomNode
class_name VisualScriptCustomFunc

export var sequenced := false setget _set_sequenced
func _set_sequenced(value):
	if not sequenced == value:
		sequenced = value
		ports_changed_notify()
func _has_input_sequence_port():
	return sequenced
func _get_output_sequence_port_count():
	return 0 + int(sequenced)

var _script : Script = self.get_script()

var _input_clues := []
var _output_clues := []
#func _custom_function(): # not implemented as overwritable func due to locking of the methods signature
#	pass

var _combined_method_info := {}
func update_combined_method_info():
	
	if not _combined_method_info.empty():
		return
	
	if not self.has_method("_custom_function"):
		printerr("VisualScriptCustomFunc requires a _custom_function(<args>) method to work.")
		return
	
	var inst_method_info:Dictionary
	var script_method_info:Dictionary
	for method in self.get_method_list():
		if method.name == "_custom_function":
			inst_method_info = method
			break
	for method in _script.get_script_method_list():
		if method.name == "_custom_function":
			script_method_info = method
			break
	for i in inst_method_info.args.size():
		inst_method_info.args[i].type = script_method_info.args[i].type
		inst_method_info.args[i]["class_name"] = script_method_info.args[i]["class_name"]
	inst_method_info.return.type = script_method_info.return.type
	inst_method_info.return["class_name"] = script_method_info.return["class_name"]
	_combined_method_info = inst_method_info
	return inst_method_info

func _get_caption():
	return _script.get_path().get_file().get_basename()

func _get_category():
	return "custom"

func _get_input_value_port_count():
	update_combined_method_info()
	return _combined_method_info.args.size()

func _get_input_value_port_hint(idx):
	if _input_clues.size() > idx and _input_clues[idx].has("hint"):
		return _input_clues[idx].get("hint")

func _get_input_value_port_hint_string(idx):
	if _input_clues.size() > idx and _input_clues[idx].has("hint_string"):
		return _input_clues[idx].get("hint_string")
	if  _combined_method_info.args[idx].get("class_name"):
		return  _combined_method_info.args[idx].get("class_name")

func _get_input_value_port_name(idx):
	if _input_clues.size() > idx and _input_clues[idx].has("name"):
		return _input_clues[idx].name
	return _combined_method_info.args[idx].name

func _get_input_value_port_type(idx):
	var default_arg_value
	if _combined_method_info.default_args.size() > idx  and _input_clues[idx].has("value"):
		default_arg_value = _combined_method_info.default_args[idx].get("value")
	var input_clues_value
	if _input_clues.size() > idx and _input_clues[idx].has("value"):
		input_clues_value = _input_clues[idx].get("value")
	if not get_default_input_value(idx):
		if input_clues_value:
			set_default_input_value(idx, input_clues_value)
		if default_arg_value:
			set_default_input_value(idx, default_arg_value)

	if _combined_method_info.args[idx].type == 0:
		if _input_clues.size() > idx and _input_clues[idx].has("type"):
			return _input_clues[idx].get("type")
		if _input_clues.size() > idx and _input_clues[idx].has("value"):
			return typeof(_input_clues[idx].get("value")) 
	return _combined_method_info.args[idx].type

func _get_output_value_port_count():
	if _combined_method_info.return.type == 0 or _combined_method_info.return.type == TYPE_ARRAY:
		if not _output_clues.empty():
			return _output_clues.size()
	return 1

func _get_output_value_port_hint(idx):
	if _combined_method_info.return.type == 0 or _combined_method_info.return.type == TYPE_ARRAY:
		if _output_clues.size() > idx:
			if _output_clues[idx].has("hint"):
				return _output_clues[idx].hint
			if _output_clues[idx].has("class_name"):
				return PROPERTY_HINT_RESOURCE_TYPE
	if _combined_method_info.return.has("hint"):
		if _combined_method_info.return.has("class_name"):# and _combined_method_info.return.get("class_name") != "":
			return PROPERTY_HINT_RESOURCE_TYPE
		return _combined_method_info.return.hint

func _get_output_value_port_hint_string(idx):
	if _combined_method_info.return.type == 0 or _combined_method_info.return.type == TYPE_ARRAY:
		if _output_clues.size() > idx:
			if  _output_clues[idx].has("value") and typeof(_output_clues[idx].value) == TYPE_OBJECT:
				return _output_clues[idx].value.get_class()
			if _output_clues[idx].has("class_name"):
				return _output_clues[idx].get("class_name")
			if _output_clues[idx].has("hint_string"):
				return _output_clues[idx].hint_string
	if _combined_method_info.return.has("hint_string") and not _combined_method_info.return.hint_string.empty():
		return _combined_method_info.return.hint_string
	if _combined_method_info.return.has("class_name"):
		return _combined_method_info.return.get("class_name")

func _get_output_value_port_name(idx):
	if _output_clues.size() > idx and _output_clues[idx].has("name"):
		return _output_clues[idx].get("name")
	return "return"

func _get_output_value_port_type(idx):
	if _combined_method_info.return.type == 0 or _combined_method_info.return.type == TYPE_ARRAY:
		if _output_clues.size() > idx:
			if _output_clues[idx].has("type"):
				return _output_clues[idx].type
			if _output_clues[idx].has("value"):
				return typeof(_output_clues[idx].value)
			if _output_clues[idx].has("hint_string"):
				if ClassDB.class_exists(_output_clues[idx].hint_string):
					return TYPE_OBJECT
			if _output_clues[idx].has("class_name"):
				if ClassDB.class_exists(_output_clues[idx].get("class_name")):
					return TYPE_OBJECT
	return _combined_method_info.return.type


func _step(inputs, outputs, start_mode, working_mem):
	if not self.has_method("_custom_function"):
		return "VisualScriptCustomFunc requires a _custom_function(<args>) method to work."
	
	if _get_output_value_port_count() > 1:
		var temp_out = self.callv("_custom_function", inputs)
		if temp_out is Array:
			for i in temp_out.size():
				outputs[i] = temp_out[i]
		else:
			outputs[0] = temp_out
	else:
		outputs[0] = self.callv("_custom_function", inputs)
	return 0
