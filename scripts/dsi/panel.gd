extends "res://scripts/object.gd"

export (Texture) var batteries_full

export (Array, Texture) var off_diodes
export (Array, Texture) var on_diodes

var enabled_diodes = 0

func _ready():
    refresh_enabled_diodes()

func _on_batteries_area_entered(area):
    if area.name == "magic_book":
        $batteries/sprite.texture = batteries_full
        Global.release(area)
        area.queue_free()
        Global.unlock(Global.Features.CARPET_UNDERGROUND_2)

func refresh_enabled_diodes():
    self.enabled_diodes = min(3, enabled_diodes)
    for i in range(3):
        var diodes = on_diodes if enabled_diodes > i else off_diodes
        get_node("diodes/diode%s" % str(i + 1)).texture = diodes[i] if len(diodes) > i else null

func _on_panel_input_event(_viewport, _event, _shape_idx):
    if Input.is_action_just_released("click") and not Global.room.get_node("animators/panel").is_playing():
        Global.room.toggle_panel(false)
