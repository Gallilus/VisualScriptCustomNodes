tool
extends VisualScriptConstantFunc

func _constant_function():
#	return "string"
#	return Input.MOUSE_MODE_CAPTURED
#	return Input.get_axis("ui_up","ui_down")
	var r = Button.new()
	r.rect_size = Vector2.ONE * 64
	return r
