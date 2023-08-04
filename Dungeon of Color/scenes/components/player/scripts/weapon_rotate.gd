func rotate(angle: int, degrees: int) -> int:
    var rotate_to := _get_rotate_to(angle, degrees)
    rotate_to = _overflow_protection(rotate_to)
    return _reverse_turn(rotate_to)

func _get_rotate_to(angle: int, degrees: int) -> int:
    if degrees > 0:
        return angle - degrees
    return angle + abs(degrees) as int

func _overflow_protection(rotate_to: int) -> int:
    if rotate_to >= GNumber.FULL_CIRCLE:
        rotate_to -= GNumber.FULL_CIRCLE
    return rotate_to

func _reverse_turn(rotate_to: int) -> int:
    if rotate_to < 0:
        rotate_to += GNumber.FULL_CIRCLE
    return rotate_to
