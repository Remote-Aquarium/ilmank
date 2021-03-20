extends "res://scripts/object.gd"

export (int) var target_hours
export (int) var target_minutes
export (int) var target_seconds

onready var hours_tick: AnimationPlayer = $clock_hours/animation
onready var minutes_tick: AnimationPlayer = $clock_minutes/animation
onready var seconds_tick: AnimationPlayer = $clock_seconds/animation

onready var ui_clock = Global.room.get_node("ui_clock")

var hours = 0
var minutes = 0
var seconds = 0

func _ready():
    for animation_player in [hours_tick, minutes_tick, seconds_tick]:
        animation_player.play("time")
        animation_player.playback_speed = 0

    var time = OS.get_time()
    set_hours(time['hour'])
    set_minutes(time['minute'])
    set_seconds(time['second'])

func set_hours(time):
    self.hours = time % 24
    hours_tick.seek(hours % 12)
    ui_clock.get_node("hours").text = str(hours).pad_zeros(2)

func set_minutes(time):
    self.minutes = time % 60;
    minutes_tick.seek(minutes / 60.0);
    ui_clock.get_node("minutes").text = str(minutes).pad_zeros(2)

func set_seconds(time):
    self.seconds = time % 60;
    seconds_tick.seek(seconds / 60.0)
    ui_clock.get_node("seconds").text = str(seconds).pad_zeros(2)

func check_time():
    if hours == target_hours and minutes == target_minutes and seconds == target_seconds \
            and not Global.is_unlocked(Global.Features.CARPET_UNDERGROUND_3):
        Global.unlock(Global.Features.CARPET_UNDERGROUND_3)

func click_zoom():
    Global.focus_foreground(ui_clock)

func _on_time_change(time_type, rel_change):
    match time_type:
        "hours":
            set_hours(self.hours + rel_change)
        "minutes":
            set_minutes(self.minutes + rel_change)
        "seconds":
            set_seconds(self.seconds + rel_change)
    check_time()
