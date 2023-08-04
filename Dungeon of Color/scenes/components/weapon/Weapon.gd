extends Area2D

var _angle := 0 # 0 90 180 270=-90
var _player_node: Player

onready var _weapon_gun_nodes := [
    $WeaponGunUp as StaticBody2D,
    $WeaponGunRight as StaticBody2D,
    $WeaponGunDown as StaticBody2D,
    $WeaponGunLeft as StaticBody2D]

onready var _take_node := $Take as AnimationPlayer
onready var _reloaded_node := $Reloaded as AudioStreamPlayer2D

func _ready() -> void:
    _set_guns_color()
    _random_rotate()

func _set_guns_color() -> void:
    for side_index in G.Sides.values():
        _weapon_gun_nodes[side_index].modulate = GColor.get_color(side_index)

func _random_rotate() -> void:
    _angle = GNumber.get_random_forward_angle()
    rotation_degrees = _angle

func _on_Weapon_area_entered(area_node: Area2D) -> void:
    if GState.ability_is_weapon and area_node is PlayerBody:
        _player_node = (area_node as PlayerBody).get_parent() as Player
        _take_node.play('take')
        _reloaded_node.play()

func _on_Take_animation_finished(_anim_name: String) -> void:
    _player_node.activate_guns(_angle)
    queue_free()
