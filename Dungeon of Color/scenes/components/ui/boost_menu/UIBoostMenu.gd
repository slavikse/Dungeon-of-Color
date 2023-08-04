extends CanvasLayer

const _DISABLE_LAYER := -1
const _ENABLE_LAYER := 2

onready var _leveling_points_value_node := $LevelingPoints/Value as Label

onready var _ui_movement_speed_node := $UIMovementSpeed as UIMovementSpeed
onready var _ui_jumping_node := $UIJumping as UIJumping
onready var _ui_jump_multiplier_node := $UIJumpMultiplier as UIJumpMultiplier
onready var _ui_jump_cooldown_node := $UIJumpCooldown as UIJumpCooldown
onready var _ui_weapon_node := $UIWeapon as UIWeapon
onready var _ui_weapon_shot_node := $UIWeaponShot as UIWeaponShot
onready var _ui_weapon_shot_cooldown_node := $UIWeaponShotCooldown as UIWeaponShotCooldown
onready var _ui_weapon_rotate_node := $UIWeaponRotate as UIWeaponRotate
onready var _ui_weapon_rotate_duration_node := $UIWeaponRotateDuration as UIWeaponRotateDuration
onready var _ui_weapon_absorb_node := $UIWeaponAbsorb as UIWeaponAbsorb

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed('ui_boost_menu'):
        _show()

    if visible:
        _ui_updates()

func _show() -> void:
    layer = _ENABLE_LAYER
    show()
    G.scene_paused(true)

func _hide() -> void:
    layer = _DISABLE_LAYER
    hide()
    G.scene_paused(false)

func _ui_updates() -> void:
    _leveling_points_update()
    _ui_movement_speed_node.update()
    _ui_jumping_node.update()
    _ui_jump_multiplier_node.update()
    _ui_jump_cooldown_node.update()
    _ui_weapon_node.update()
    _ui_weapon_shot_node.update()
    _ui_weapon_shot_cooldown_node.update()
    _ui_weapon_rotate_node.update()
    _ui_weapon_rotate_duration_node.update()
    _ui_weapon_absorb_node.update()

func _leveling_points_update() -> void:
    _leveling_points_value_node.text = str(GState.player_leveling_points)

func _on_Distribute_pressed() -> void:
    _hide()
