extends "res://scripts/room.gd"

const GameObject = preload("res://scripts/object.gd")

func _ready():
    toggle_panel(false, false)
    var objects = get_node("objects")
    var books = objects.get_node("books")
    for book in books.get_children():
        books.remove_child(book)
        objects.add_child(book)
    books.queue_free()

func unlock(feature):
    match feature:
        Global.Features.PAINTING:
            $"objects/painting".grabbable = true
        Global.Features.CARPET_UNDERGROUND_1, \
        Global.Features.CARPET_UNDERGROUND_2, \
        Global.Features.CARPET_UNDERGROUND_3:
            $objects/panel.enabled_diodes += 1
            $objects/panel.refresh_enabled_diodes()
    if Global.is_unlocked(Global.Features.TOTEM_FULL) and Global.is_unlocked(Global.Features.CASTLES):
        for object in $objects.get_children():
            if object is GameObject:
                object.end_game()
        $animators/end.play("hide_shelf")
        yield($animators/end, "animation_finished")

func toggle_panel(state, animate=true):
    if state:
        $objects/carpet.visible = false
        $objects/panel.visible = true
        if animate:
            $animators/panel.play("pop")
    else:
        if animate:
            $animators/panel.play("hide")
            yield($animators/panel, "animation_finished")
        $objects/panel.visible = false
        $objects/carpet.visible = true
