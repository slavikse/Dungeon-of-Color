const _MOVEMENT := 1.0
const _DECELERATION_FACTOR := 0.8

var _jump_script := preload('../jump/scripts/_jump.gd') as GDScript
var _jump_instance = _jump_script.new()
var _jump_velocity := Vector2.ZERO

func get_velocity() -> Vector2:
    var velocity := _get_move_velocity()
    _jump_velocity = Vector2(_jump_instance.multiplier(velocity))
    _check_status_jumping()
    return _apply_deceleration_factor(velocity)

func _get_move_velocity() -> Vector2:
    var velocity := Vector2.ZERO
    if Input.is_action_pressed('move_up'): velocity.y -= _MOVEMENT
    if Input.is_action_pressed('move_right'): velocity.x += _MOVEMENT
    if Input.is_action_pressed('move_down'): velocity.y += _MOVEMENT
    if Input.is_action_pressed('move_left'): velocity.x -= _MOVEMENT
    return velocity.normalized()

func _check_status_jumping() -> void:
    if _jump_velocity != Vector2.ZERO and not GState.status_is_jumping:
        # Из-за задержек анимации, время таймера отстаёт, поэтому изменяется в HUDJumping.gd
        GState.status_is_jumping = true

func _apply_deceleration_factor(velocity: Vector2) -> Vector2:
    var accelerated_velocity := _accelerated_velocity(velocity)
    if GState.status_is_weapon: accelerated_velocity *= _DECELERATION_FACTOR
    return accelerated_velocity

func _accelerated_velocity(velocity: Vector2) -> Vector2:
    return ((velocity + _jump_velocity) * GState.player_movement_speed).round()

func get_jump_velocity() -> Vector2: return _jump_velocity
func has_jump_animation() -> bool: return _jump_instance.has_jump_animation()
func has_jump_cooldown_initial() -> bool: return _jump_instance.has_jump_cooldown_initial()
