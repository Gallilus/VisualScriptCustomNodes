tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"int","type":TYPE_INT},
			{"name":"int", "value": 1},
			{"name":"int_RANGE_even", "value": 1, "hint":PROPERTY_HINT_RANGE, "hint_string":"-360, 360, 2"},
			{"name":"int_EXP_RANGE_even", "value": 1, "hint":PROPERTY_HINT_EXP_RANGE, "hint_string":"-360, 360, 2"},
			{"name":"int_ENUM", "value": 1, "hint":PROPERTY_HINT_ENUM, "hint_string":"i, love, this, enum"},
			{"name":"int_FLAGS", "value": 1, "hint":PROPERTY_HINT_FLAGS, "hint_string":"Bit0,Bit1,Bit2,,Bit4"},
			{"name":"int_LAYERS_2D_PHYSICS", "value": 1, "hint":PROPERTY_HINT_LAYERS_2D_PHYSICS, "hint_string":"Bit0,Bit1,Bit2,,Bit100"},
			{"name":"int_LAYERS_2D_RENDER", "value": 1, "hint":PROPERTY_HINT_LAYERS_2D_RENDER},
			{"name":"int_LAYERS_3D_PHYSICS", "value": 1, "hint":PROPERTY_HINT_LAYERS_3D_PHYSICS},
			{"name":"int_LAYERS_3D_RENDER", "value": 1, "hint":PROPERTY_HINT_LAYERS_3D_RENDER},
			]

func _custom_function(a,b,c,d,e,f,g,h,i,j):
	pass
