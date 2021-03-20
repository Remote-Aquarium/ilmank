extends "res://scripts/object.gd"

var current_style = null

func _ready():
    set_carpet("default")

func set_carpet(style):
    if current_style != null:
        current_style.visible = false
        var collision = get_node("collision")
        remove_child(collision)
        current_style.add_child(collision)
    var carpet_style = get_node(style)
    carpet_style.visible = true
    var collision = carpet_style.get_node("collision")
    carpet_style.remove_child(collision)
    add_child(collision)
    self.current_style = carpet_style

