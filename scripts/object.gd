extends Area2D

class_name GameObject

export var grabbable = false
export var weight = 100
export var smoothness = 25

onready var initial_z_index = self.z_index

var grabbing = false

func _process(delta):
    if Input.is_action_just_released("click") and grabbing:
        grab(false)
        Global.release(self)

    if grabbing:
        self.global_position = lerp(global_position, get_global_mouse_position(), smoothness * delta)

func is_on_top(ignore_brothers=true):
    for area in get_overlapping_areas():
        if not is_greater_than(area) and area.is_visible_in_tree():
            if ignore_brothers and area as GameObject and area.weight < weight:
                continue
            return false
    return true

func _on_Object_input_event(_viewport, _event, _shape_idx):
    if Input.is_action_just_pressed("click"):
        if grabbable and not grabbing:
            if is_on_top() and Global.try_grab(self):
                grab(true)
        elif not grabbable:
            pass
    elif Input.is_action_just_released("click_zoom"):
        click_zoom()

func grab(grab):
    self.grabbing = grab
    if grabbing:
        self.z_index = 100
    else:
        self.z_index = initial_z_index
    if grab:
        self.get_parent().move_child(self, self.get_parent().get_child_count())

func click_zoom():
    pass
