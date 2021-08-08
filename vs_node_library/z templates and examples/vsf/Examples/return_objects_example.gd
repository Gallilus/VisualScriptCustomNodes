tool
extends VisualScriptCustomFunc

func _init():
	_output_clues = [
			{"name":"Hint any object class", "type":TYPE_OBJECT, "hint":PROPERTY_HINT_RESOURCE_TYPE, "hint_string":"Sprite"},
			{"name":"Value any object", "value":Sprite.new()},
			{"name":"Any object class", "class_name":"Sprite"},
			
			
			{"name":"RigidBody", "value":RigidBody.new()},
			{"name":"AnimatedTexture", "value":AnimatedTexture.new()},
			{"name":"AudioStreamMP3", "value":AudioStreamMP3.new()},
			
			]

func _custom_function():
	pass
