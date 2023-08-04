extends Node2D

const _ROTATE_DURATION := 0.4
var _is_toggle_activated := false
var _is_status_is_weapon := false # При переключении состояния оружия даст 1 тик, чтобы перекрасить пушки.

onready var _hud_arrow_nodes := [
    $HUDArrowUp as Node2D,
    $HUDArrowRight as Node2D,
    $HUDArrowDown as Node2D,
    $HUDArrowLeft as Node2D]
onready var _interpolate_node := $Interpolate as Tween
onready var _activate_node := $Activate as AnimationPlayer

func _ready() -> void:
    for side_index in G.Sides.values():
        _colour_timer(side_index)
        _black_arrow(side_index)

func _process(_delta: float) -> void:
    if _is_status_is_weapon == true:
        for side_index in G.Sides.values():
            _has_start_reload(int(side_index))
            _update_arrow_color(int(side_index))
        _has_rotation()
        _toggle_activate_wrap(true)
    else:
        _prevent_rotation()
        _toggle_activate_wrap(false)

    if GState.status_is_weapon:
        _is_status_is_weapon = true
    else:
        _is_status_is_weapon = false

func _colour_timer(side_index: int) -> void:
    _hud_arrow_nodes[side_index].set_timer_color(GColor.get_color(side_index))

func _black_arrow(side_index: int) -> void:
    _hud_arrow_nodes[side_index].set_texture_color(GColor.BLACK)

func _has_start_reload(side_index: int) -> void:
    if _has_not_available(side_index):
        _start_reload(side_index)

func _has_not_available(side_index: int) -> bool:
    return _hud_arrow_nodes[side_index].get_texture_color() == GColor.BLACK\
        and GState.colors_weapon_guns[side_index] == GColor.BLACK

func _start_reload(side_index: int) -> void:
    _hud_arrow_nodes[side_index].timer_start()

func _update_arrow_color(side_index: int) -> void:
    _hud_arrow_nodes[side_index].set_texture_color(GState.colors_weapon_guns[side_index])

func _has_rotation() -> void:
   if rotation_degrees != -GState.player_rotation_degrees:
        _rotation_interpolate()

func _rotation_interpolate() -> void:
    if not _interpolate_node.is_active():
        #warning-ignore:RETURN_VALUE_DISCARDED
        _interpolate_node.interpolate_property(
            self, 'rotation_degrees',
            rotation_degrees, -GState.player_rotation_degrees,
            _ROTATE_DURATION,
            Tween.TRANS_BACK, Tween.EASE_OUT)
        #warning-ignore:RETURN_VALUE_DISCARDED
        _interpolate_node.start()

func _prevent_rotation() -> void:
    rotation_degrees = -GState.player_rotation_degrees

func _toggle_activate_wrap(is_active: bool) -> void:
    if _is_toggle_activated != is_active:
        _toggle_activate(is_active)
    _is_toggle_activated = is_active

func _toggle_activate(is_active: bool) -> void:
    if is_active:
        _activate_node.play('activate')
    else:
        _activate_node.play('deactivate')
        _reset_timer()

func _reset_timer() -> void:
    for side_index in G.Sides.values():
        _hud_arrow_nodes[side_index].timer_stop()
