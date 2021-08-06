tool
extends EditorPlugin

func _enter_tree():
	VisualScriptEditor.add_custom_node("Autoload", "data", preload("res://addons/VisualScriptCustomNodes/CustomNodes/Autoload.gd"))
	VisualScriptEditor.add_custom_node("MousePos", "data", preload("res://addons/VisualScriptCustomNodes/CustomNodes/MousePos.gd"))
	VisualScriptEditor.add_custom_node("StringConstants", "data", preload("res://addons/VisualScriptCustomNodes/CustomNodes/StringConstants.gd"))
	VisualScriptEditor.add_custom_node("ErrorNode", "flow_control", preload("res://addons/VisualScriptCustomNodes/CustomNodes/ErrorNode.gd"))
	VisualScriptEditor.add_custom_node("PrintFormat", "flow_control", preload("res://addons/VisualScriptCustomNodes/CustomNodes/PrintFormat.gd"))

func _exit_tree():
	VisualScriptEditor.remove_custom_node("Autoload", "data")
	VisualScriptEditor.remove_custom_node("MousePos", "data")
	VisualScriptEditor.remove_custom_node("StringConstants", "data")
	VisualScriptEditor.remove_custom_node("ErrorNode", "flow_control")
	VisualScriptEditor.remove_custom_node("PrintFormat", "flow_control")
