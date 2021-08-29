tool
extends VisualScriptCustomNode

var engine_singletons :PoolStringArray= [
		"Performance",
		"ProjectSettings",
		"IP",
		"Geometry",
		"ResourceFormatLoader",
		"ResourceFormatSaver",
		"OS",
		"Engine",
		"ClassDB",
		"Marshalls",
		"TranslationServer",
		"Input",
		"InputMap",
		"JSON",
		"JavaClassWrapper",
		"JavaScript",
		"NavigationMeshGenerator",
		"VisualScriptEditor",
		"VisualServer",
		"PhysicsServer",
		"Physics2DServer",
		"ARVRServer",
		"CameraServer",
		"GDScriptLanguageProtocol",
	]

var singleton : String = engine_singletons[11] setget _set_singleton
func _set_singleton(value):
	if not singleton == value:
		singleton = value
		ports_changed_notify()

func _get_autoloads():
	var autoloads := []
	for prop in ProjectSettings.get_property_list():
		if prop.name.begins_with("autoload/"):
			autoloads.append(prop.name.lstrip("autoload/"))
	return autoloads

func _get_property_list() -> Array:
	var properties = []
	var autoloads := ""
	for action in _get_autoloads():
		autoloads += action
		autoloads += ","
	for action in engine_singletons:
		autoloads += action
		autoloads += ","
	autoloads = autoloads.rstrip(",")
	
	properties.append({
		name = "singleton",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = autoloads,
		usage = PROPERTY_USAGE_DEFAULT
	})
	return properties

var _instance : Object
func update_instance():
	if Engine.has_singleton(singleton):
		_instance = Engine.get_singleton(singleton)
	if not singleton == " ":
		_instance = load(ProjectSettings.get_setting("autoload/"+singleton).lstrip("*")).new()

func _get_category():
	return "data"

func _get_caption():
	return singleton

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
	if Engine.has_singleton(singleton):
		return Engine.get_singleton(singleton).get_class()
	if not singleton == " ":
		return load(ProjectSettings.get_setting("autoload/"+singleton).lstrip("*")).new().get_class()

func _get_output_value_port_name(_idx):
	return ""

func _get_output_value_port_type(_idx):
	return TYPE_OBJECT

func _step(inputs, outputs, _start_mode, _working_mem):
	if !inputs[0]:
		return "Input[0] not connected to self"
	
	if Engine.get_singleton(singleton):
		outputs[0] = Engine.get_singleton(singleton)
	elif not singleton == " ":
		outputs[0] = inputs[0].get_node("/root/"+singleton)
	else:
		return "autoload \'" + singleton + "\' not recognised. case-sensitive spelling!"
	
	return 0
