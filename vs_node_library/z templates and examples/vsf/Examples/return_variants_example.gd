tool
extends VisualScriptCustomFunc

func _init():
	_output_clues = [
			{"name":"H_bool", "type":TYPE_BOOL},
			{"name":"v_bool", "value":false},
			{"name":"H_int", "type":TYPE_INT},
			{"name":"v_int", "value":0},
			{"name":"H_float", "type":TYPE_REAL},
			{"name":"V_float", "value":0.0},
			{"name":"H_string", "type":TYPE_STRING},
			{"name":"V_string", "value":"a"},
			{"name":"H_Vector2", "type":TYPE_VECTOR2},
			{"name":"V_Vector2", "value":Vector2.UP},
			{"name":"H_Rect2", "type":TYPE_RECT2},
			{"name":"V_Rect2", "value":Rect2(Vector2.UP, Vector2.UP)},
			{"name":"H_Vector3", "type":TYPE_VECTOR3},
			{"name":"V_Vector3", "value":Vector3.UP},
			{"name":"H_Transform2D", "type":TYPE_TRANSFORM2D},
			{"name":"V_Transform2D", "value":Transform2D(Vector2.UP, Vector2.UP, Vector2.UP)},
			{"name":"H_Plane", "type":TYPE_PLANE},
			{"name":"V_Plane", "value":Plane(Vector3.UP, 0.0)},
			{"name":"H_Quat", "type":TYPE_QUAT},
			{"name":"V_Quat", "value":Quat(Vector3.UP)},
			{"name":"H_AABB", "type":TYPE_AABB},
			# add value example
			{"name":"H_Basis", "type":TYPE_BASIS},
			# add value example
			{"name":"H_Transform", "type":TYPE_TRANSFORM},
			# add value example
			{"name":"H_Color", "type":TYPE_COLOR},
			# add value example
			{"name":"H_NodePath", "type":TYPE_NODE_PATH},
			# add value example
			{"name":"H_RID", "type":TYPE_RID},
			# add value example
			{"name":"H_Object", "type":TYPE_OBJECT},
			# add value example
			{"name":"H_Dictionary", "type":TYPE_DICTIONARY},
			# add value example
			{"name":"H_Array", "type":TYPE_ARRAY},
			{"name":"V_Array", "value":[]},
			{"name":"H_Array_byte", "type":TYPE_RAW_ARRAY},
			# add value example
			{"name":"H_Array_int", "type":TYPE_INT_ARRAY},
			# add value example
			{"name":"H_Array_float", "type":TYPE_REAL_ARRAY},
			# add value example
			{"name":"H_Array_string", "type":TYPE_STRING_ARRAY},
			# add value example
			{"name":"H_Array_Vector2", "type":TYPE_VECTOR2_ARRAY},
			# add value example
			{"name":"H_Array_Vector3", "type":TYPE_VECTOR3_ARRAY},
			# add value example
			{"name":"H_Array_Color", "type":TYPE_COLOR_ARRAY},
			# add value example
			]

func _custom_function():
	pass
