tool
extends VisualScriptCustomFunc

func _init():
	_input_clues = [
			{"name":"bool_H", "type":TYPE_BOOL},
			{"name":"bool", "value":false},
			{"name":"Vector2_H", "type":TYPE_VECTOR2},
			{"name":"Vector2", "value":Vector2.UP},
			{"name":"Rect2_H", "type":TYPE_RECT2},
			{"name":"Rect2", "value":Rect2(Vector2.UP, Vector2.UP)},
			{"name":"Vector3_H", "type":TYPE_VECTOR3},
			{"name":"Vector3", "value":Vector3.UP},
			{"name":"Transform2D_H", "type":TYPE_TRANSFORM2D},
			{"name":"Transform2D", "value":Transform2D(Vector2.UP, Vector2.UP, Vector2.UP)},
			{"name":"Plane_H", "type":TYPE_PLANE},
			{"name":"Plane", "value":Plane(Vector3.UP, 0.0)},
			{"name":"Quat_H", "type":TYPE_QUAT},
			{"name":"Quat", "value":Quat(Vector3.UP)},
			{"name":"AABB_H", "type":TYPE_AABB},
			# add value example
			{"name":"Basis_H", "type":TYPE_BASIS},
			# add value example
			{"name":"Transform_H", "type":TYPE_TRANSFORM},
			# add value example
			{"name":"Color_H", "type":TYPE_COLOR},
			{"name":"Color_V", "value":Color.rebeccapurple},
			{"name":"NodePath_H", "type":TYPE_NODE_PATH},
			# add value example
			{"name":"RID_H", "type":TYPE_RID},
			# add value example
			{"name":"Object_H", "type":TYPE_OBJECT},
			# add value example
			{"name":"Dictionary_H", "type":TYPE_DICTIONARY},
			# add value example
			{"name":"Array_H", "type":TYPE_ARRAY},
			{"name":"Array_H", "value":[]},
			{"name":"Array_byte_H", "type":TYPE_RAW_ARRAY},
			# add value example
			{"name":"Array_int_H", "type":TYPE_INT_ARRAY},
			# add value example
			{"name":"Array_float_H", "type":TYPE_REAL_ARRAY},
			# add value example
			{"name":"Array_string_H", "type":TYPE_STRING_ARRAY},
			# add value example
			{"name":"Array_Vector2_H", "type":TYPE_VECTOR2_ARRAY},
			# add value example
			{"name":"Array_Vector3_H", "type":TYPE_VECTOR3_ARRAY},
			# add value example
			{"name":"Array_Color_H", "type":TYPE_COLOR_ARRAY},
			# add value example
			]

func _custom_function(a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,a1,b1,c1,d1,e1,f1):
	pass
