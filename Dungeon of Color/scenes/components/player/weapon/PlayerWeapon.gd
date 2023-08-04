extends Node2D
class_name PlayerWeapon

signal deactivate(side_index)
signal rotate_right()
signal is_needles_active(is_active)

var _is_available := false
var _quantity_active := -1

onready var _needles_needle_nodes := [
    $Needles/NeedleUp as Polygon2D,
    $Needles/NeedleRight as Polygon2D,
    $Needles/NeedleDown as Polygon2D,
    $Needles/NeedleLeft as Polygon2D]

onready var _player_gun_nodes := [
    $PlayerGunUp as PlayerGun,
    $PlayerGunRight as PlayerGun,
    $PlayerGunDown as PlayerGun,
    $PlayerGunLeft as PlayerGun]

onready var _absorb_node := $Absorb as AnimationPlayer
onready var _absorption_node := $Absorption as AudioStreamPlayer2D

func _ready() -> void:
    _set_guns_side()
    _set_guns_color()

func _physics_process(_delta: float) -> void:
    _weapon_turn()
    _weapon_absorb()
    GState.status_is_weapon = _is_available

func _set_guns_side() -> void:
    for side_index in G.Sides.values():
        _player_gun_nodes[side_index].set_side_index(side_index)

func _set_guns_color() -> void:
    for side_index in G.Sides.values():
        _player_gun_nodes[side_index].modulate = GColor.get_color(side_index)

func can_shot() -> void:
    for side_index in G.Sides.values():
        _player_gun_nodes[side_index].shot_side(side_index)

func _weapon_turn() -> void:
    if _is_available\
        and not GState.player_is_game_over\
        and not GState.status_is_weapon_rotate\
        and Input.is_action_just_pressed('weapon_turn'):
        emit_signal('rotate_right')

func _weapon_absorb() -> void:
    if _is_available\
        and not GState.player_is_game_over\
        and not GState.status_is_weapon_rotate\
        and GState.ability_is_weapon_absorb\
        and Input.is_action_just_pressed('weapon_absorb'):
        _get_leveling_point()
        _absorb_node.play('absorb')
        emit_signal('is_needles_active', false)

func _get_leveling_point() -> void:
    GState.player_leveling_points += 1

func _on_Absorb_animation_finished(anim_name: String) -> void:
    if anim_name == 'absorb':
        _absorb_node.play('RESET') # bug .stop(true) - не сбрасывает анимацию.
        _deactivate_guns()
        _hide_needles()
        _weapon_absorbed()
        emit_signal('is_needles_active', true)

func _weapon_absorbed() -> void:
    _absorption_node.play()

func _on_Absorption_finished() -> void:
    Input.action_press('ui_boost_menu')

func _deactivate_guns() -> void:
    for side_index in len(_player_gun_nodes):
        _player_gun_nodes[side_index].deactivate_from_weapon()

func _hide_needles() -> void:
    for side_index in len(_needles_needle_nodes):
        _hide_needle(side_index)

func _hide_needle(side_index: int) -> void:
    _needles_needle_nodes[side_index].hide()

func activate_guns() -> void:
    for player_gun_node in _player_gun_nodes:
        player_gun_node.activate()
    _weapon_activated()
    _show_needles()

func _weapon_activated() -> void:
    _is_available = true
    _quantity_active = len(_player_gun_nodes)
    show()

func _show_needles() -> void:
    for side_index in len(_needles_needle_nodes):
        _needles_needle_nodes[side_index].show()

func _on_PlayerGun_deactivate(side_index) -> void:
    _hide_needle(side_index)
    _decrement_quantity_active()
    _check_weapon_deactivated()
    emit_signal('deactivate', side_index)

func _decrement_quantity_active() -> void:
    _quantity_active -= 1

func _check_weapon_deactivated() -> void:
    if _quantity_active == 0:
        _is_available = false
        hide()
