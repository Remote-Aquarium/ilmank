extends Node

var current_grab = null
var cursor = null

func _ready():
    change_scene()

func change_scene():
    cursor = $"/root/Game/Cursor"

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
