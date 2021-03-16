extends Node2D

func _ready():
    Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _process(_delta):
    self.position = self.get_global_mouse_position()

func set_grabbing(grabbing):
    if not grabbing:
        $sprite.texture = preload("res://assets/cursor/cursor_default.svg")
    else:
        $sprite.texture = preload("res://assets/cursor/cursor_grab.svg")

