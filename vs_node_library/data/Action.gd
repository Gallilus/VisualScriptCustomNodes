tool
extends VisualScriptCustomNode

export var exact := false
export var raw := false

var positive_action : String = InputMap.get_actions()[0] setget set_positive_action
func set_positive_action(value):
	if not positive_action == value:
		positive_action = value
		ports_changed_notify()

var negative_action : String = " " setget set_negative_action
func set_negative_action(value):
	if not negative_action == value:
		negative_action = value
		ports_changed_notify()

func _get_property_list() -> Array:
	var properties = []
	var actions := ""
	for action in InputMap.get_actions():
		actions += action
		actions += ","
	actions = actions.rstrip(",")
	
	properties.append({
		name = "positive_action",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = actions,
		usage = PROPERTY_USAGE_DEFAULT
	})
	properties.append({
		name = "negative_action",
		type = TYPE_STRING,
		hint = PROPERTY_HINT_ENUM,
		hint_string = " ," + actions,
		usage = PROPERTY_USAGE_DEFAULT
	})
	return properties

func _get_category():
	return "data"

func _get_caption():
	if negative_action == " ":
		return positive_action
#	var overlap := ""
#	for i in positive_action.length():
#		if positive_action[i] == negative_action[i]:
#			overlap += positive_action[i]
	return positive_action + " - " + negative_action #.lstrip(overlap)

func _get_output_value_port_count():
	return 1

func _get_output_value_port_name(_idx):
	return "strength"

func _get_output_value_port_type(_idx):
	return TYPE_REAL

func _step(_inputs, outputs, start_mode, _working_mem):
	if not negative_action == " ":
		outputs[0] = Input.get_axis(negative_action, positive_action)
		return 0
	
	if raw:
		outputs[0] = Input.get_action_raw_strength(positive_action, exact)
	else:
		outputs[0] = Input.get_action_strength(positive_action, exact)
	return 0
