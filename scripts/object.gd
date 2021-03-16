extends Area2D

export var grabbable = false
export var smoothness = 25

var grabbing = false

func _process(delta):
    if Input.is_action_just_released("click") and grabbing:
        grab(false)
        Global.release(self)

    if grabbing:
        self.global_position = lerp(global_position, get_global_mouse_position(), smoothness * delta)

func _on_Object_input_event(_viewport, _event, _shape_idx):
    if Input.is_action_just_pressed("click"):
        if grabbable and not grabbing:
            var areas = get_overlapping_areas()
            if areas.size() > 0:
                for area in areas:
                    if not is_greater_than(area) and area.is_visible_in_tree():
                        return
            if Global.try_grab(self):
                grab(true)
        elif not grabbable:
            pass

func grab(grab):
    self.grabbing = grab
    if grab:
        self.get_parent().move_child(self, self.get_parent().get_child_count())

