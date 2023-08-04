extends Polygon2D
class_name PlayerEye

signal movement_side(is_up, is_right, is_down, is_left)

const _STEP := 8
const _UP := Vector2(0, -_STEP)
const _RIGHT := Vector2(_STEP, 0)
const _DOWN := Vector2(0, _STEP)
const _LEFT := Vector2(-_STEP, 0)
const _UP_RIGHT := Vector2(_STEP, -_STEP)
const _UP_LEFT := Vector2(-_STEP, -_STEP)
const _DOWN_RIGHT := Vector2(_STEP, _STEP)
const _DOWN_LEFT := Vector2(-_STEP, _STEP)
const _MOVEMENT_DURATION := 0.2

const _UP_SIDE := [true, false, false, false]
const _RIGHT_SIDE := [false, true, false, false]
const _DOWN_SIDE := [false, false, true, false]
const _LEFT_SIDE := [false, false, false, true]
const _UP_RIGHT_SIDES := [true, true, false, false]
const _DOWN_RIGHT_SIDES := [false, true, true, false]
const _DOWN_LEFT_SIDES := [false, false, true, true]
const _UP_LEFT_SIDES := [true, false, false, true]
const _CENTER_SIDE := [false, false, false, false]

onready var _body_node := $Body as Polygon2D
onready var _body_increase_node := $Body/Increase as AnimationPlayer
onready var _body_movement_node := $Body/Movement as Tween

func movement(vector: Vector2) -> void:
    if vector.x == 0:
        _horizontal(vector)
    elif vector.y == 0:
        _vertical(vector)
    elif vector.x < 0:
        _left_corner(vector)
    elif vector.x > 0:
        _right_corner(vector)

    if vector == Vector2.ZERO:
        _center()

func _horizontal(vector: Vector2) -> void:
    if vector.y > 0:
        _set_body_position(_DOWN)
        emit_signal('movement_side', _DOWN_SIDE)
    elif vector.y < 0:
        _set_body_position(_UP)
        emit_signal('movement_side', _UP_SIDE)

func _vertical(vector: Vector2) -> void:
    if vector.x > 0:
        _set_body_position(_RIGHT)
        emit_signal('movement_side', _RIGHT_SIDE)
    elif vector.x < 0:
        _set_body_position(_LEFT)
        emit_signal('movement_side', _LEFT_SIDE)

func _left_corner(vector: Vector2) -> void:
    if vector.y > 0:
        _set_body_position(_DOWN_LEFT)
        emit_signal('movement_side', _DOWN_LEFT_SIDES)
    elif vector.y < 0:
        _set_body_position(_UP_LEFT)
        emit_signal('movement_side', _UP_LEFT_SIDES)

func _right_corner(vector: Vector2) -> void:
    if vector.y > 0:
        _set_body_position(_DOWN_RIGHT)
        emit_signal('movement_side', _DOWN_RIGHT_SIDES)
    elif vector.y < 0:
        _set_body_position(_UP_RIGHT)
        emit_signal('movement_side', _UP_RIGHT_SIDES)

func _center() -> void:
    _set_body_position(Vector2.ZERO)
    emit_signal('movement_side', _CENTER_SIDE)

func _set_body_position(new_position: Vector2) -> void:
    #warning-ignore:RETURN_VALUE_DISCARDED
    _body_movement_node.interpolate_property(
        _body_node, 'position',
        _body_node.position, new_position,
        _MOVEMENT_DURATION,
        Tween.TRANS_BACK, Tween.EASE_OUT)
    #warning-ignore:RETURN_VALUE_DISCARDED
    _body_movement_node.start()

func increase() -> void:
    _body_increase_node.play('increase')
