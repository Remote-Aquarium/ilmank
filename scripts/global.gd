extends Node

var current_grab = null

var room = null
var foreground_ui = null
var cursor = null

func _ready():
    change_scene()

func _process(_delta):
    if Input.is_action_just_released("esc") and foreground_ui != null:
        focus_foreground(null)

func change_scene():
    room = $"/root/Game/RoomView"
    cursor = $"/root/Game/Cursor"

func focus_foreground(node):
    if foreground_ui != null:
        foreground_ui.visible = false
    self.foreground_ui = node
    if node != null:
        node.visible = true
    check_blur(foreground_ui != null)

func check_blur(blur_state):
    if room != null:
        var shaders = room.get_node("shaders")
        if shaders != null:
            shaders.visible = blur_state

# Grabbing

func try_grab(object):
    if not object is Object:
        return false

    if current_grab == null:
        current_grab = object
        if cursor != null:
            cursor.set_grabbing(true)
    return current_grab == object

func release(object):
    if current_grab == object:
        current_grab = null
        if cursor != null:
            cursor.set_grabbing(false)

func is_grabbing():
    return current_grab != null

# Features

enum Features {
    PAINTING = 1 << 0,
    CARPET_UNDERGROUND_1 = 1 << 2,
    CARPET_UNDERGROUND_2 = 1 << 3,
    CARPET_UNDERGROUND_3 = 1 << 4,
}

var unlocked_features = 0

func unlock(feature):
    self.unlocked_features |= feature
    print("Unlocked feature %s" % feature)
    if room != null:
        room.unlock(feature)

func is_unlocked(feature):
    return self.unlocked_features & feature != 0
