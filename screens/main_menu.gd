extends Control

onready var background_animator = $UI/background_animator

func _ready():
    background_animator.play("blur")

func _on_play_pressed():
    var game = load("res://screens/game.tscn").instance()
    Global.change_scene(game)

func _on_settings_pressed():
    pass

func _on_leave_pressed():
    get_tree().quit()
