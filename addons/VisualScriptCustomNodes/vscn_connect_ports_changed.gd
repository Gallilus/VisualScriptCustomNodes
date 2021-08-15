extends Node

var editor_plugin : EditorPlugin
var script_editor : ScriptEditor

var visual_script_editor
var graph_edit : GraphNode

func _enter_tree():
	if editor_plugin:
		script_editor = editor_plugin.get_editor_interface().get_script_editor()
		script_editor.connect("editor_script_changed", self, "_on_editor_script_changed", [script_editor])

func _on_editor_script_changed(_script, script_editor):
	_find_VisualScriptEditor(script_editor)
	pass

func _find_VisualScriptEditor(node):
	if node.name.begins_with("VisualScriptEditor"):
		visual_script_editor = node
		_find_GraphEdit(node)
		return
	for child in node.get_children():
		var t = _find_VisualScriptEditor(child)

func _find_GraphEdit(node):
	if node.name.begins_with("GraphEdit"):
		graph_edit = node
		return
	for child in node.get_children():
		var t = _find_GraphEdit(child)

