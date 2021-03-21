extends "res://scripts/object.gd"

onready var monitor = get_parent().get_node("monitor")

func _on_drop_computer_area_entered(area):
    if area.name == "computer":
        $drop_computer.queue_free()
        area.queue_free()
        $cables.queue_free()
        $qi_negatif.visible = true
        monitor.power_on()
