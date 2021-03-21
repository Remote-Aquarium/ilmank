extends "res://scripts/object.gd"

var toggled = false

func toggle():
    self.toggled = !toggled
    if toggled:
        $animator.play("push_down")
    else:
        $animator.play_backwards("push_down")
    get_parent().get_node("carpet").set_carpet("unlocked" if toggled else "default")

func _on_lever_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.is_pressed() and event.button_mask == BUTTON_RIGHT:
        if not is_on_top(false) or Global.is_grabbing():
            return
        toggle()

