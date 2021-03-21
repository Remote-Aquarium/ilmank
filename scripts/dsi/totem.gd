extends "res://scripts/object.gd"

var moon_good = false
var cross_good = false
var star_good = false

func _on_totem_area_entered(area):
    var unlocked = false
    if area.name == "bible_book" and not cross_good:
        unlock("cross")
        self.cross_good = true
        unlocked = true
    elif area.name == "artefact_moon" and not moon_good:
        unlock("moon")
        self.moon_good = true
        unlocked = true
    elif area.name == "artefact_star" and not star_good:
        unlock("star")
        self.star_good = true
        unlocked = true
    if unlocked:
        Global.release(area)
        area.queue_free()
        if moon_good and cross_good and star_good and \
                not Global.is_unlocked(Global.Features.TOTEM_FULL):
            Global.unlock(Global.Features.TOTEM_FULL)

func unlock(artefact):
    get_node("placeholders/%s_put" % artefact).visible = true
