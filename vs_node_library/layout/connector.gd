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

export var connections := 1 setget _set_connections
func _set_connections(value):
	if not value == connections:
		if value < 0:
			value = 0
		connections = value
		ports_changed_notify()

export var caption := ">>>" setget _set_caption
func _set_caption(value):
	if not value == caption:
		caption = value
		ports_changed_notify()

func _get_category():
	return "flow_control"

func _get_caption():
	return caption

var data_hints := []

func _get_input_value_port_count():
	if data_hints.size() < connections:
		data_hints.resize(connections)
		for i in connections:
			if not data_hints[i]:
				data_hints[i] = {"hint":0,"hint_string":"","name":"","type":0}
	return connections

func _get_input_value_port_hint(idx):
	return data_hints[idx]["hint"]

func _get_input_value_port_hint_string(idx):
	return data_hints[idx]["hint_string"]

func _get_input_value_port_name(idx):
	return data_hints[idx]["name"]

func _get_input_value_port_type(idx):
	return data_hints[idx]["type"]

func _get_output_value_port_count():
	return connections

func _get_output_value_port_hint(idx):
	return _get_input_value_port_hint(idx)

func _get_output_value_port_hint_string(idx):
	return _get_input_value_port_hint_string(idx)

func _get_output_value_port_name(idx):
	return _get_input_value_port_name(idx)

func _get_output_value_port_type(idx):
	return _get_input_value_port_type(idx)

func _step(inputs, outputs, _start_mode, _working_mem):
	for i in connections:
		outputs[i] = inputs[i]
	return 0
