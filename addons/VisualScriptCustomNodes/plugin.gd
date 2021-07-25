tool
extends EditorPlugin

func _enter_tree():
	VisualScriptEditor.add_custom_node("Autoload", "data", preload("res://addons/VisualScriptCustomNodes/CustomNodes/Autoload.gd"))
	VisualScriptEditor.add_custom_node("ErrorNode", "flow_control", preload("res://addons/VisualScriptCustomNodes/CustomNodes/ErrorNode.gd"))

func _exit_tree():
	VisualScriptEditor.remove_custom_node("Autoload", "data")
	VisualScriptEditor.remove_custom_node("ErrorNode", "flow_control")
