const _VELOCITY := 400
const _VELOCITY_UP := Vector2(0, -_VELOCITY)
const _VELOCITY_RIGHT := Vector2(_VELOCITY, 0)
const _VELOCITY_DOWN := Vector2(0, _VELOCITY)
const _VELOCITY_LEFT := Vector2(-_VELOCITY, 0)
const _VELOCITIES_MUTABLE := [_VELOCITY_UP, _VELOCITY_RIGHT, _VELOCITY_DOWN, _VELOCITY_LEFT]
const _VELOCITIES_IMMUTABLE := [_VELOCITY_UP, _VELOCITY_RIGHT, _VELOCITY_DOWN, _VELOCITY_LEFT]

func get_velocity(index: int) -> Vector2:
    return Vector2(_VELOCITIES_MUTABLE[index])

func turn_velocities_right() -> void:
    var velocity_front := Vector2(_VELOCITIES_MUTABLE.pop_front())
    _VELOCITIES_MUTABLE.append(velocity_front)

func reset_velocities_mutable() -> void:
    _VELOCITIES_MUTABLE[0] = _VELOCITY_UP
    _VELOCITIES_MUTABLE[1] = _VELOCITY_RIGHT
    _VELOCITIES_MUTABLE[2] = _VELOCITY_DOWN
    _VELOCITIES_MUTABLE[3] = _VELOCITY_LEFT

func get_velocity_immutable(index: int) -> Vector2:
    return Vector2(_VELOCITIES_IMMUTABLE[index])
