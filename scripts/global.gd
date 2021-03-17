extends Node

var current_grab = null

var room = null
var cursor = null

func _ready():
    change_scene()

func change_scene():
    room = $"/root/Game/RoomView"
    cursor = $"/root/Game/Cursor"

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

# Features

enum Features {
    PAINTING = 1 << 0,
}

var unlocked_features = 0

func unlock(feature):
    self.unlocked_features |= feature
    print("Unlocked feature %s" % feature)
    if room != null:
        room.unlock(feature)

func is_unlocked(feature):
    return self.unlocked_features & feature != 0
