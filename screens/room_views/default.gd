extends "res://scripts/room.gd"

func _ready():
    toggle_panel(false, false)

func unlock(feature):
    match feature:
        Global.Features.PAINTING:
            $"objects/painting".grabbable = true

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
