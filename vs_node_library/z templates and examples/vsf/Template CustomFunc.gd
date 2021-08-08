tool
extends VisualScriptCustomFunc

func _init():
#	sequenced = true
	_input_clues = [
			{"name":"in1", "value": 3.0},
			{"name":"in2", "value": Vector3.FORWARD},
			]
	_output_clues = [
			{"name":"out1", "type":TYPE_VECTOR3},
			{"name":"out2", "value":RigidBody.new()},
			]

func _custom_function(a,b):
	return [a*b, RigidBody]
