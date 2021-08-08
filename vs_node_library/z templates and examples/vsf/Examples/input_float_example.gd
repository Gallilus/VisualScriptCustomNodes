tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"float", "type":TYPE_REAL},
			{"name":"float", "value": 1.5},
			{"name":"float_RANGE_halve", "value": 1.5, "hint":PROPERTY_HINT_RANGE, "hint_string":"-360, 360, 0.5"},
			{"name":"float_EXP_RANGE_halve", "value": 1.5, "hint":PROPERTY_HINT_EXP_RANGE, "hint_string":"-360, 360, 0.5"},
			{"name":"float_EXP_EASING", "value": 1.5, "hint":PROPERTY_HINT_EXP_EASING, "hint_string":"inout"},
			]

func _custom_function(a,b,c,d,e):
	pass
