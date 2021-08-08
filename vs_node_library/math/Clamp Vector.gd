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

enum _types {VECTOR2, VECTOR3}
var _type := 1
export (_types) var type := 1 setget set_type, get_type
func get_type():
	return _type
func set_type(value):
	if not value == _type:
		_type = value
		if _type == 0:
			_clamp_idx &= ~(1 << 2); #reset Z
		elif _type == 1:
			_clamp_idx |= (1 << 2); #set Z
		property_list_changed_notify()
		ports_changed_notify()

enum _clamp_idxs {X,Y,Z, MAGNITUDE}
var _clamp_idx := 15
export (int, FLAGS, "X", "Y", "Z", "Magnitude") var idxs := 7 setget set_clamp_idx, get_clamp_idx
func get_clamp_idx():
	return _clamp_idx
func set_clamp_idx(value):
	if not value == _clamp_idx:
		_clamp_idx = value
		if _type == 0:
			_clamp_idx &= ~(1 << 2);
		property_list_changed_notify()
		ports_changed_notify()

func _get_category():
	return "operators"

func _get_caption():
	var r := "Clamp"
	if _clamp_idx & 1:
		r += " X"
	if _clamp_idx & 2:
		r += " Y"
	if _clamp_idx & 4:
		r += " Z"
	if _clamp_idx & 8:
		r += " Length"
	return r

func _get_input_value_port_count():
	return 3

func _get_input_value_port_name(idx):
	match idx:
		0:
			return "min"
		1:
			return "value"
		2:
			return "max"

func _get_input_value_port_type(_idx):
	if _type == 0:
		return TYPE_VECTOR2
	return TYPE_VECTOR3


func _get_output_value_port_count():
	return 1

#func _get_output_value_port_name(idx):
#	return "val"

func _get_output_value_port_type(_idx):
	if _type == 0:
		return TYPE_VECTOR2
	return TYPE_VECTOR3

func _step(inputs, outputs, _start_mode, _working_mem):
	var _min = inputs[0]
	var _val = inputs[1]
	var _max = inputs[2]
	var _result = _val
	
	if _clamp_idx & 1:
		_result.x = clamp(_val.x,_min.x,_max.x)
	if _clamp_idx & 2:
		_result.y = clamp(_val.y,_min.y,_max.y)
	if _clamp_idx & 4:
		_result.z = clamp(_val.z,_min.z,_max.z)
	if _clamp_idx & 8:
		if _result.length() < _min.length():
			_result = _val.normalized() * _min.length()
		elif _result.length() > _max.length():
			_result = _val.normalized() * _max.length()
	outputs[0]= _result
	return 0
