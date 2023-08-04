extends Node2D
class_name PlayerNeedles

onready var _player_needles_nodes := [
    $PlayerNeedleUp as PlayerNeedle,
    $PlayerNeedleRight as PlayerNeedle,
    $PlayerNeedleDown as PlayerNeedle,
    $PlayerNeedleLeft as PlayerNeedle]

func activate(side_index: int) -> void:
    _player_needles_nodes[side_index].activate()

func rotate_left() -> void:
    rotation_degrees -= GNumber.RIGHT_ANGLE

func _on_PlayerEye_movement_side(sides: Array) -> void:
    _reset_sizes()
    _pull_out_antennae(sides)

func _reset_sizes() -> void:
    for side_index in len(_player_needles_nodes):
        _player_needles_nodes[side_index].normal_size()

func _pull_out_antennae(sides: Array) -> void:
    # [0]: up side:    [up]    [right] = [0] [1]
    # [1]: right side: [right] [down]  = [1] [2]
    # [2]: down side:  [down]  [left]  = [2] [3]
    # [3]: left side:  [left]  [up]    = [3] [0]
    for side_index in len(sides):
        if sides[side_index]:
            _stretch_size(side_index)
            _last_out_antennae(side_index, sides)

func _last_out_antennae(side_index: int, sides: Array) -> void:
    if side_index + 1 == len(sides):
        _stretch_size(0)
    else:
        _stretch_size(side_index + 1)

func _stretch_size(side_index: int) -> void:
    _player_needles_nodes[side_index].stretch_size(side_index)
