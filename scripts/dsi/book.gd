extends "res://scripts/object.gd"

export (String) var open_page_path

var page = null

func _ready():
    if open_page_path != null:
        self.page = Global.room.get_node_or_null(open_page_path)

func click_zoom():
    if page != null:
        Global.focus_foreground(page)
