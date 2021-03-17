extends Node2D

export (Array, int) var codes_seq = [0]

var seq_index = 0

func input_drawer_code(drawer_code):
    if seq_index >= len(codes_seq):
        return

    if codes_seq[seq_index] == drawer_code:
        self.seq_index += 1
        if self.seq_index == len(codes_seq):
            Global.unlock(Global.Features.PAINTING)
    else:
        self.seq_index = 0

