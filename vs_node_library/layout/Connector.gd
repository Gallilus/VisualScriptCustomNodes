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

var visual_script
var instance_function := ""
var instance_id := -1

var _initialised := false
func _get_caption():
	if not _initialised:
		_init()
		_initialised = true
#	return "ctr+shft+r"
	return ">>>"

func _init():
	if not is_instance_valid(visual_script):
		visual_script = get_visual_script()
		#print(visual_script)
	if is_instance_valid(visual_script):
		if visual_script.has_method("_node_ports_changed"):
			if not visual_script.is_connected("node_ports_changed", self, "_node_ports_changed"):
				visual_script.connect("node_ports_changed", self, "_node_ports_changed")
				#print("re_connected")
		

func _node_ports_changed(function: String, id: int):
	if not is_instance_valid(visual_script):
		return
	if visual_script.get_node(function, id) == self:
		instance_function = function
		instance_id = id
		_update_ports()

#	_get_data_port_destinations(visual_script,function,id,1)
func _update_ports():
	print("*************visual_script*************")
	var cl = get_data_connection_list(visual_script,instance_function)
	print (cl)
	var loc = connection_list_to_list_of_connections(cl)
	print(loc)
	print(get_connection_sources(loc,instance_id,0))
	print(get_connection_destinations(loc,instance_id,0))
	var t =visual_script.get_node(instance_function, 14)
	
	diagnostics(t)
		

func diagnostics(diagnose_me):
	print(diagnose_me)
#	print(diagnose_me.get_method_list())
#	for m in diagnose_me.get_method_list():
	for m in diagnose_me.get_property_list():
		#print(m.name)
		if m.name == "VisualScriptNode":
			print(m)
	#print(diagnose_me.get("VisualScriptNode"))


func get_sequence_connection_list(visual_script:VisualScript, function:String) -> Array:
	var r = []
	for f in visual_script.data.functions:
		if f.name == function:
			r = f.sequence_connections
	return r
func get_data_connection_list(visual_script:VisualScript, function:String) -> Array:
	var r = []
	for f in visual_script.data.functions:
		if f.name == function:
			r = f.data_connections
	return r

func connection_list_to_list_of_connections(connections:Array) -> Array:
	# connections [start_node,start_idx, end_node,end_idx]
	var r := []
	var i := 0
	while i < connections.size():
		r.push_front(connections.slice(i, i+ 3))
		i+=4
	return r

func get_connection_sources(list_of_connections:Array, node_id:int, port_id:int) -> Array:
	var r := []
	for connection in list_of_connections:
		if connection[2] == node_id and connection[3] == port_id:
			r.append([connection[0], connection[1]])
	return r

func get_connection_destinations(list_of_connections:Array, node_id:int, port_id:int) -> Array:
	var r := []
	for connection in list_of_connections:
		if connection[0] == node_id and connection[1] == port_id:
			r.append([connection[2], connection[3]])
	return r





func _get_category():
	return "flow_control"

#func _get_caption():
##	return "ctr+shft+r"
#	return ">>>"

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
