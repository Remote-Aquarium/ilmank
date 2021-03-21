extends "res://scripts/object.gd"

onready var internal_parent = get_parent()
onready var external_parent = Global.room.get_node("objects")

var current_state = null
var computerContext = true

func _ready():
    for state in get_children():
        state.visible = false
    set_state("computer")

func _process(delta):
    ._process(delta)
    if grabbing:
        var overlap_monitor = false
        for area in get_overlapping_areas():
            if area.name == "monitor":
                overlap_monitor = true
                break

        if computerContext:
            if overlap_monitor:
                return
            for area in get_overlapping_areas():
                if area.name == "context_bridge":
                    return
        elif not computerContext:
            if not overlap_monitor:
                return

        grab(false)
        get_parent().remove_child(self)
        self.computerContext = !computerContext
        set_state("computer" if computerContext else "wild")
        var new_parent = internal_parent if computerContext else external_parent
        new_parent.add_child(self)
        self.global_position = get_global_mouse_position()
        grab(true)

func set_state(state):
    if current_state != null:
        current_state.visible = false
        var collision = get_node("collision")
        remove_child(collision)
        current_state.add_child(collision)

    var computer_state = get_node(state)
    if computer_state != null:
        computer_state.visible = true
        var collision = computer_state.get_node("collision")
        computer_state.remove_child(collision)
        add_child(collision)
    self.current_state = computer_state
