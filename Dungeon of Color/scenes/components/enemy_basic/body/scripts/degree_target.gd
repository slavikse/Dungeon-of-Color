const _INACCURACY = 0.01

func get_random_degree_target(center_position: Vector2, target_position: Vector2) -> int:
    var vector := _avoid_null_vector((center_position - target_position).normalized())
    var target_degree := 0

    if vector.x < 0 and vector.y < 0:
        target_degree = int(GFunc.get_random_value_from_list([GNumber.LEFT_ANGLE, GNumber.UP_ANGLE]))
    elif vector.x > 0 and vector.y < 0:
        target_degree = int(GFunc.get_random_value_from_list([GNumber.RIGHT_ANGLE, GNumber.UP_ANGLE]))
    elif vector.x < 0 and vector.y > 0:
        target_degree = int(GFunc.get_random_value_from_list([GNumber.LEFT_ANGLE, GNumber.DOWN_ANGLE]))
    elif vector.x > 0 and vector.y > 0:
        target_degree = int(GFunc.get_random_value_from_list([GNumber.RIGHT_ANGLE, GNumber.DOWN_ANGLE]))
    else:
        print('_get_random_degree_target / Не обработанное значение! ', vector)

    return target_degree

func _avoid_null_vector(vector: Vector2) -> Vector2:
    if vector.x == 0:
        vector.x += _get_inaccuracy()
    if vector.y == 0:
        vector.y += _get_inaccuracy()
    return vector

func _get_inaccuracy() -> int:
    return int(GFunc.get_random_value_from_list([-_INACCURACY, +_INACCURACY]))

func get_movement_degree(vector: Vector2) -> int:
    var movement_degree := 0
    if vector.y < 0: movement_degree = GNumber.UP_ANGLE
    elif vector.x > 0: movement_degree = GNumber.RIGHT_ANGLE
    elif vector.y > 0: movement_degree = GNumber.DOWN_ANGLE
    elif vector.x < 0: movement_degree = GNumber.LEFT_ANGLE
    else: print('get_movement_degree / Не обработанное значение! ', vector)
    return movement_degree

func get_target_direction(center_position: Vector2, target_position: Vector2) -> int:
    var target_vector := (center_position - target_position).round()
    if target_vector.y > 0: return int(G.Sides.UP)
    if target_vector.x < 0: return int(G.Sides.RIGHT)
    if target_vector.y < 0: return int(G.Sides.DOWN)
    if target_vector.x > 0: return int(G.Sides.LEFT)
    return -1
