extends "res://scripts/object.gd"

export (Texture) var batteries_empty

export (Array, Texture) var off_diodes
export (Array, Texture) var on_diodes

var enabled_diodes = 0

func _ready():
    refresh_enabled_diodes()

func _on_batteries_area_entered(area):
    if area.name == "magic_book":
        $batteries/sprite.texture = batteries_empty

func refresh_enabled_diodes():
    self.enabled_diodes = min(3, enabled_diodes)
    for i in range(3):
        var diodes = on_diodes if enabled_diodes > i else off_diodes
        get_node("diodes/diode%s" % str(i + 1)).texture = diodes[i] if len(diodes) > i else null

