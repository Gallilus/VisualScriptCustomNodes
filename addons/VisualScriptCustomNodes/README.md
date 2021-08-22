VisualScriptCustomNodes
===
[github](https://github.com/Gallilus/VisualScriptCustomNodes), [issues](https://github.com/Gallilus/VisualScriptCustomNodes/issues)

# Description

A Library of visualscriptnodes to extend Godot VisualScript
10+ new nodes in 5 categories.
multiple examples of how to create your own nodes.
2 new class of VisualScriptCustomNode to implement easier node creation
 
# Getting started

Drag a node from the library in to a VisualScript

## Examples

In 'res://vs_node_library/z templates and examples/' you  may find examples for VisualScriptCustomNode (vsc) and VisualScriptCustomFunc (vsf)
These are there to help you create your own.

## Contribute
If you want to contribute your work to this library simple post your script and maybe a small demo project of its implementation on the GitHub [issues](https://github.com/Gallilus/VisualScriptCustomNodes/issues) page.

## Creating a new custom node
1. Custom Node
    [GODOT DOCS](https://docs.godotengine.org/en/stable/getting_started/scripting/visual_script/custom_visualscript_nodes.html#creating-a-custom-node)
    From Godot3.4 you will be able to overwrite,
    
    ```
    func _get_input_value_port_hint(idx):
        return TYPE_...
    func _get_input_value_port_hint_string(idx):
        return ""
    func _get_output_value_port_hint(idx):
        return PROPERTY_HINT_...
    func _get_output_value_port_hint_string(idx):
        return ""
    ```

    
2. Function Node
    1. To create a new node you have to create a new `tool` script.
    2. `extends VisualScriptCustomFunc`
    3. Overwrite function `_custom_function()`
    4. Node_name is the same as the script_name.
    ```
    tool
    extends VisualScriptCustomFunc

    func _custom_function():
        return "value"
    ```
    5. On init you are able to set if the node default is sequenced.
    6. On init you are able to give input and output clues.
    ```
    func _init():
        sequenced = true
        _input_clues = [
                {"name":"in1", "value": 3.0},
                {"name":"in2", "value": Vector3.FORWARD},
                ]
        _output_clues = [
                {"name":"out1", "type":TYPE_VECTOR3},
                {"name":"out2", "value":RigidBody.new()},
                ]
    ```
3. Drag this script in your VisualScript
Alternatively you are able to create a `VisualScriptCustomNode` and assign the script to it.

# advanced users

## _input_clues and _output_clues
Just like in other scripts you would like to expose more details about your variable to the editor so that the editor in return will help you specifie that information.

Therefore `VisualScriptCustomFunc` has two arrays `_input_clues` `_output_clues` which you may populate on `_init()` wit property dictionary’s to help the editor, colleagues read the intent.

Property dictionary’s are able to hold 5 key values.
* "name" = String
* "type" = int (Variant.Type `TYPE_...`)
* "value" = any
* "hint" = int (PropertyHint `PROPERTY_HINT_...`)
* "hint_string" = String

By default the node will try to guess as many clues as possible.
The specified clues overrule this automated guess. 
:::info
Default argument names and values are **not yet** working as intended so always specify them by using `_input_clues` `_output_clues`
:::

### _output_clues extra

The return type will be used to for `_output_clues`.
When there is no return.type or return.type is TYPE_ARRAY. You are able to hint and use multiple output ports.
1. Return type is `Array` or nothing.
2. `_output_clues` needs multiple property dictionary’s
3. Function **must** return array of values

## Sequencing
The sequence port of `VisualScriptCustomFunc` is optional.
By default `sequenced` is `false`.
When you have a function that is not returning any value it will be best to default `sequenced` to `true` on `_init()`.

## warning

Please do not overwrite `VisualScriptCustomNode` functions.

# Known issues

`VisualScriptConstant`
- Will run singlton actions like `Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)` on the ditor.
    - Running the function in editor is overkill it is the only way to automaticly get full output information

`VisualScriptCustomFunc`
- Property dictionary’s not able to get `name`, `value` from function definition.

# Appendix and FAQ
:::info
**Want to contribute to the library?** Leave a comment on the GitHub [issues](https://github.com/Gallilus/VisualScriptCustomNodes/issues)
:::

# Other Links
[youtube](https://www.youtube.com/channel/UC01q_FIsQgEs2Lil0qtgpPA)
[itch.io](https://gallilus.itch.io/visualscript-customnodes)
[patreon](https://www.patreon.com/Gallilus)