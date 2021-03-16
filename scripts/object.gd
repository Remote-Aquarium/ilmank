extends Area2D

export var grabbable = false
export var smoothness = 25

var grabbing = false

func _process(delta):
    if Input.is_action_just_released("click") and grabbing:
        grabbing = false
        Global.release(self)

    if grabbing:
        self.global_position = lerp(global_position, get_global_mouse_position(), smoothness * delta)

func _on_Object_input_event(_viewport, _event, _shape_idx):
    if Input.is_action_just_pressed("click"):
        if grabbable and not grabbing:
            if Global.try_grab(self):
                grabbing = true
        elif not grabbable:
            pass

