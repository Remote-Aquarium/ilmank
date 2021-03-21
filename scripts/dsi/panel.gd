extends "res://scripts/object.gd"

export (Texture) var batteries_full

export (Array, Texture) var off_diodes
export (Array, Texture) var on_diodes

export (String) var target_music

onready var ui_radio = Global.room.get_node("ui_radio")
onready var radio_musics = ui_radio.get_node("musics")

var enabled_diodes = 0

func _ready():
    refresh_enabled_diodes()

func _on_batteries_area_entered(area):
    if area.name == "magic_book" and not Global.is_unlocked(Global.Features.CARPET_UNDERGROUND_2):
        $batteries/sprite.texture = batteries_full
        Global.release(area)
        area.queue_free()
        Global.unlock(Global.Features.CARPET_UNDERGROUND_2)

func refresh_enabled_diodes():
    self.enabled_diodes = min(3, enabled_diodes)
    for i in range(3):
        var diodes = on_diodes if enabled_diodes > i else off_diodes
        get_node("diodes/diode%s" % str(i + 1)).texture = diodes[i] if len(diodes) > i else null
    if enabled_diodes == 3 and not Global.is_unlocked(Global.Features.PANEL_LOCKER):
        Global.unlock(Global.Features.PANEL_LOCKER)
        $locker/animator.play("open")

func _on_panel_input_event(_viewport, _event, _shape_idx):
    if Input.is_action_just_released("click") and not Global.room.get_node("animators/panel").is_playing():
        Global.room.toggle_panel(false)

func _on_radio_input_event(_viewport, event, _shape_idx):
    if event is InputEventMouseButton and event.is_pressed() and event.button_mask == BUTTON_RIGHT:
        if not is_on_top(false) or Global.is_grabbing():
            return
        Global.focus_foreground(ui_radio)

func _on_play_button_pressed():
    if Global.is_unlocked(Global.Features.CARPET_UNDERGROUND_1):
        return
    for music in radio_musics.get_children():
        var invalid = not music.is_pressed() if music.name == target_music else music.is_pressed()
        if invalid:
            return
    Global.unlock(Global.Features.CARPET_UNDERGROUND_1)
