extends "res://scripts/room.gd"

func unlock(feature):
    match feature:
        Global.Features.PAINTING:
            $"objects/painting".grabbable = true
