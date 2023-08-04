const _COORDINATES := ['x', 'y']
const _VELOCITY_INACCURACY := 0.1
const _RATIO_SOFTENING := 0.2

var _velocity := Vector2.ZERO
var _is_jump_cooldown_initial := false
var _is_jump_animation := false

func multiplier(velocity: Vector2) -> Vector2:
    _move_jump(velocity)
    _damping()
    return _velocity

func has_jump_animation() -> bool: return _is_jump_animation
func has_jump_cooldown_initial() -> bool: return _is_jump_cooldown_initial

func _move_jump(velocity: Vector2) -> void:
    if GState.ability_is_jumping and Input.is_action_just_pressed('move_jump'):
        _jump_animation(velocity)
    else:
        _not_jump_animation()

func _jump_animation(velocity: Vector2) -> void:
    if GState.status_is_jump_cooldown:
        _is_jump_cooldown_initial = true
    else:
        _is_jump_animation = true
        _jump_multiply(velocity)
        _jump_cooldown(velocity)

func _jump_multiply(velocity: Vector2) -> void:
    _velocity = velocity * GState.player_jump_multiplier

func _jump_cooldown(velocity: Vector2) -> void:
    if velocity != Vector2.ZERO:
        GState.status_is_jump_cooldown = true

func _not_jump_animation() -> void:
    _is_jump_animation = false
    _is_jump_cooldown_initial = false

func _damping() -> void:
    if _velocity != Vector2.ZERO:
        for coordinate in _COORDINATES:
            _increment_velocity(String(coordinate))
            _decrement_velocity(String(coordinate))
            _reject_inaccuracy(String(coordinate))

func _increment_velocity(coordinate: String) -> void:
    if _velocity[coordinate] < _VELOCITY_INACCURACY:
        _velocity[coordinate] += abs(_velocity[coordinate] * _RATIO_SOFTENING)

func _decrement_velocity(coordinate: String) -> void:
    if _velocity[coordinate] > _VELOCITY_INACCURACY:
        _velocity[coordinate] -= _velocity[coordinate] * _RATIO_SOFTENING

func _reject_inaccuracy(coordinate: String) -> void:
    if abs(_velocity[coordinate]) < _VELOCITY_INACCURACY:
        _velocity[coordinate] = 0
