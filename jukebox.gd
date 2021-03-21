extends Node

export (AudioStream) var start
export (AudioStream) var loop

onready var audio_player = $audio_player
var on_loop = false

func _ready():
    if start != null:
        audio_player.stream = start
    else:
        audio_player.stream = loop
        on_loop = true
    if audio_player.stream != null:
        audio_player.play()

func _on_audio_player_finished():
    if not on_loop:
        audio_player.stream = loop
        self.on_loop = true
    if audio_player.stream != null:
        audio_player.play()
