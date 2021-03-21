extends Area2D

export (String) var expected_area

func _on_area_entered(area):
    if area.name == expected_area:
        $sprite.visible = true
        Global.release(area)
        area.queue_free()
