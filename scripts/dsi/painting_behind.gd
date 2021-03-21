extends "res://scripts/object.gd"

func _on_valid_button_pressed():
    if Global.is_unlocked(Global.Features.CASTLES):
        return
    var valid_sprites = 0
    for placeholder in $placeholders.get_children():
        valid_sprites += int(placeholder.get_node("sprite").visible)
    if valid_sprites == 3:
        Global.unlock(Global.Features.CASTLES)
        $screen.frame = 1
    else:
        $screen.frame = 2

