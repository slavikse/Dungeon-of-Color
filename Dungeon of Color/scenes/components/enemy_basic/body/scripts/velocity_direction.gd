const _AXIS_X := 0
const _AXIS_Y := 1
const _SIGN_MINUS := -1
const _SIGN_PLUS := +1

func get_random_velocity_direction(movement_speed: int) -> Vector2:
    var axis := _get_random_axis()
    var axis_sign := _get_random_axis_sign()
    return _calc_velocity(axis, axis_sign, movement_speed)

func _get_random_axis() -> int:
    return int(GFunc.get_random_value_from_list([_AXIS_X, _AXIS_Y]))

func _get_random_axis_sign() -> int:
    return int(GFunc.get_random_value_from_list([_SIGN_MINUS, _SIGN_PLUS]))

func _calc_velocity(axis: int, axis_sign: int, movement_speed: int) -> Vector2:
    var velocity := Vector2.ZERO
    velocity[axis] += axis_sign * movement_speed
    return velocity

func get_target_velocity_direction(target_degree: int, movement_speed: int) -> Vector2:
    var axis: int
    var axis_sign: int

    if target_degree == GNumber.UP_ANGLE:
        axis = _AXIS_Y
        axis_sign = _SIGN_MINUS
    elif target_degree == GNumber.RIGHT_ANGLE:
        axis = _AXIS_X
        axis_sign = _SIGN_PLUS
    elif target_degree == GNumber.DOWN_ANGLE:
        axis = _AXIS_Y
        axis_sign = _SIGN_PLUS
    elif target_degree == GNumber.LEFT_ANGLE:
        axis = _AXIS_X
        axis_sign = _SIGN_MINUS
    else:
        print('get_target_velocity_direction / Не обработанное значение! ', target_degree)

    return _calc_velocity(axis, axis_sign, movement_speed)
