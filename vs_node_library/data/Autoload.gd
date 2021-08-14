tool
extends VisualScriptCustomNode

export var valid := false setget set_valid
func set_valid(_value):
	pass
func _set_valid(value):
	if value != valid:
		valid = value
		ports_changed_notify()
		property_list_changed_notify()
	if valid:
		update_instance()
var _valid_autoload := false
var _valid_singleton := false

var _autoloads := []
func update_autoloads():
	var autoloads := []
	for prop in ProjectSettings.get_property_list():
		if prop.name.begins_with("autoload/"):
			autoloads.append(prop.name.lstrip("autoload/"))
	_autoloads = autoloads

export var autoload := "" setget _set_autoload
func _set_autoload(value):
	autoload = value
	update_autoloads()
	if _autoloads.has(autoload):
		_valid_autoload = true
		_valid_singleton = false
		_set_valid(true)
	elif Engine.has_singleton(autoload):
		_valid_autoload = false
		_valid_singleton = true
		_set_valid(true)
	else:
		_valid_autoload = false
		_valid_singleton = false
		_set_valid(false)
	
var _instance : Object
func update_instance():
	if _valid_autoload:
		_instance = load(ProjectSettings.get_setting("autoload/"+autoload).lstrip("*")).new()
	elif _valid_singleton:
		_instance = Engine.get_singleton(autoload)

func _get_category():
	return "data"

func _get_caption():
	return "Autoload"

func _get_input_value_port_count():
	return 1

func _get_input_value_port_name(_idx):
	return "self"

func _get_input_value_port_type(_idx):
	return TYPE_OBJECT

func _get_output_value_port_count():
	return 1

func _get_output_value_port_hint(_idx):
	return PROPERTY_HINT_RESOURCE_TYPE

func _get_output_value_port_hint_string(_idx):
	if _instance:
		return _instance.get_class()

func _get_output_value_port_name(_idx):
	if valid:
		return autoload
	else:
		return "config error"

func _get_output_value_port_type(_idx):
	return TYPE_OBJECT

func _step(inputs, outputs, _start_mode, _working_mem):
	if !inputs[0]:
		return "Input[0] not connected to self"
	if !valid:
		return "autoload \'" + autoload + "\' not recognised. case-sensitive spelling!"
	
	if _valid_autoload:
		outputs[0] = inputs[0].get_node("/root/"+autoload)
	elif _valid_singleton:
		outputs[0] = Engine.get_singleton(autoload)
	
	return 0
