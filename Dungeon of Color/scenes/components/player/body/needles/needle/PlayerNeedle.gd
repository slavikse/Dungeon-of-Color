extends Area2D
class_name PlayerNeedle

const _SIDE := -10.0
const _STRETCH_POSITIONS := [
    Vector2(0, -_SIDE), # up
    Vector2(_SIDE, 0),  # right
    Vector2(0, _SIDE),  # down
    Vector2(-_SIDE, 0)] # left
const _STRETCH_SIZE := Vector2(1, 1.6)
const _NORMAL_POSITION := Vector2.ZERO
const _NORMAL_SIZE := Vector2(1, 1)
const _SIZING_TIME := 0.1

onready var _visible_node := $Visible as AnimationPlayer
onready var _positions_node := $Positions as Tween
onready var _size_node := $Size as Tween
onready var _sliding_show_node := $SlidingShow as AudioStreamPlayer2D
onready var _sliding_hide_node := $SlidingHide as AudioStreamPlayer2D

func activate() -> void:
    _visible_node.play('show')

func _on_PlayerNeedle_area_entered(area_node: Area2D) -> void:
    if area_node is CommonWall:
        _deactivate()

func _deactivate() -> void:
    _visible_node.play('hide')

func _on_PlayerNeedle_area_exited(area_node: Area2D) -> void:
    if area_node is CommonWall:
        activate()

func stretch_size(side_index: int) -> void:
    _interpolates(_STRETCH_POSITIONS[side_index], _STRETCH_SIZE)
    _sliding_show_node.play()

func _interpolates(positions: Vector2, size: Vector2) -> void:
    _interpolate(_positions_node, 'position', position, positions)
    _interpolate(_size_node, 'scale', scale, size)

func _interpolate(tween_node: Tween, property: String, value: Vector2, target: Vector2) -> void:
    #warning-ignore:RETURN_VALUE_DISCARDED
    tween_node.interpolate_property(
        self, property,
        value, target,
        _SIZING_TIME,
        Tween.EASE_OUT, Tween.EASE_IN)
    #warning-ignore:RETURN_VALUE_DISCARDED
    tween_node.start()

func normal_size() -> void:
    _interpolates(_NORMAL_POSITION, _NORMAL_SIZE)
    _sliding_hide_node.play()
