extends "res://scripts/object.gd"

var running = false
var current_screen = null

func _ready():
    for screen in $screens.get_children():
        screen.visible = false
    set_screen("default")

func power_on():
    if running:
        return
    set_screen("powered_on")
    self.running = true

func set_screen(screen_name):
    var screen = get_node("screens/%s" % screen_name)
    if current_screen != null:
        current_screen.visible = false
    if screen != null:
        screen.visible = true
    self.current_screen = screen
