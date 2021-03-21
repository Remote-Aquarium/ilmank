extends "res://scripts/object.gd"

export var code = 0
export var pull_shift_down = 0
export (Texture) var open_texture

var initialTexture = null
var pulled = false
var inspected_view = null

func _ready():
    self.initialTexture = $sprite.texture
    if code == 1:
        self.inspected_view = Global.room.get_node("ui_drawer_inspected")

func _on_drawer_input_event(viewport, event, shape_idx):
    ._on_Object_input_event(viewport, event, shape_idx)
    if event is InputEventMouseButton and event.is_pressed() and event.button_mask == BUTTON_LEFT:
        pulled = !pulled
        $sprite.texture = open_texture if pulled else initialTexture
        $sprite.position += Vector2(0, (1 if pulled else -1) * pull_shift_down)
        if pulled and code != 0:
            get_parent().input_drawer_code(code)

func click_zoom():
    if pulled:
        Global.focus_foreground(inspected_view)
