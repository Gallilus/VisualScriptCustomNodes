tool
extends EditorPlugin

func _enter_tree():
	VisualScriptEditor.add_custom_node("ErrorNode", "flow_control", preload("res://vs_node_library/debug/ErrorNode.gd"))
	VisualScriptEditor.add_custom_node("PrintFormat", "flow_control", preload("res://vs_node_library/debug/PrintFormat.gd"))

func _exit_tree():
	VisualScriptEditor.remove_custom_node("ErrorNode", "flow_control")
	VisualScriptEditor.remove_custom_node("PrintFormat", "flow_control")
