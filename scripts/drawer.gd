extends Area2D

export var code = 0
export var pull_shift_down = 0
export (Texture) var open_texture

var initialTexture = null
var pulled = false

func _ready():
    self.initialTexture = $sprite.texture

func _on_drawer_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.is_pressed():
        pulled = !pulled
        $sprite.texture = open_texture if pulled else initialTexture
        $sprite.position += Vector2(0, (1 if pulled else -1) * pull_shift_down)
        if pulled and code != 0:
            get_parent().input_drawer_code(code)

