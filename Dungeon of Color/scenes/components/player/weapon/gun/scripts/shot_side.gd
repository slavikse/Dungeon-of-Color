const _SHOT_SIDES := ['shot_up', 'shot_right', 'shot_down', 'shot_left']

func get_shot_side(index: int) -> String:
    return _SHOT_SIDES[index]

func turn_weapon_right() -> void:
    var side_front := String(_SHOT_SIDES.pop_front())
    _SHOT_SIDES.append(side_front)

func get_shot_sides() -> Array: return _SHOT_SIDES

func reset_shot_sides() -> void:
    _SHOT_SIDES[0] = 'shot_up'
    _SHOT_SIDES[1] = 'shot_right'
    _SHOT_SIDES[2] = 'shot_down'
    _SHOT_SIDES[3] = 'shot_left'
