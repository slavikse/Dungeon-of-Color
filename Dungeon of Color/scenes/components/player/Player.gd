extends KinematicBody2D
class_name Player

export(GDScript) var _movement_script: GDScript
onready var _movement_instance = _movement_script.new()
export(GDScript) var _weapon_rotate_script: GDScript
onready var _weapon_rotate_instance = _weapon_rotate_script.new()

onready var _collision_nodes := [
    $CollisionUp as CollisionShape2D,
    $CollisionRight as CollisionShape2D,
    $CollisionDown as CollisionShape2D,
    $CollisionLeft as CollisionShape2D]
onready var _player_body_node := $PlayerBody as PlayerBody
onready var _player_jump_node := $PlayerJump as PlayerJump
onready var _player_weapon_node := $PlayerWeapon as PlayerWeapon
onready var _player_rotation_node := $PlayerRotation as PlayerRotation
onready var _weapon_rotate_node := $WeaponRotate as AudioStreamPlayer2D

func _process(_delta: float) -> void:
    if not GState.player_is_game_over:
        _movement_instance.get_jump_velocity()
        _player_jump_node.can_jump(_movement_instance)
        _player_weapon_node.can_shot()

func _physics_process(_delta: float) -> void:
    if not GState.player_is_game_over:
        var velocity := Vector2(_movement_instance.get_velocity())
        #warning-ignore:RETURN_VALUE_DISCARDED
        move_and_slide(velocity)
        _player_body_node.eye_movement(velocity)

func activate_guns(angle: int) -> void:
    _player_weapon_node.activate_guns()
    _activate_guns_collision()
    _weapon_rotate_to(angle)

func _activate_guns_collision() -> void:
    for side_index in len(_collision_nodes):
        _change_gun_collision(int(side_index), false)

func _change_gun_collision(side_index: int, is_disabled: bool) -> void:
    _collision_nodes[side_index].set_deferred('disabled', is_disabled)

func _weapon_rotate_to(angle: int) -> void:
    var rotate_to := int(_weapon_rotate_instance.rotate(angle, rotation_degrees))
    rotation_degrees = angle
    _player_body_node.rotate_left(rotate_to)

func _on_PlayerWeapon_deactivate(side_index: int) -> void:
    _change_gun_collision(side_index, true)
    _player_body_node.activate_needles(side_index)

func _on_PlayerWeapon_rotate_right() -> void:
    if GState.ability_is_weapon_rotate:
        _weapon_rotate_right()
        # Из-за задержек анимации, время таймера отстаёт, поэтому изменяется в HUDWeaponRotate.gd
        GState.status_is_weapon_rotate = true

func _weapon_rotate_right() -> void:
    var is_active := _player_rotation_node.rotate(self, rotation_degrees)
    if not is_active:
        _player_body_node.rotate_left(GNumber.RIGHT_ANGLE)
        _weapon_rotate_node.play()

func _on_Room_rotate_right() -> void:
    _weapon_rotate_right()

func _on_WeaponTurn_rotate_right() -> void:
    _weapon_rotate_right()
