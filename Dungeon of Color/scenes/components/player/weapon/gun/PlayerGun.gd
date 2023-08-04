extends Area2D
class_name PlayerGun

export(GDScript) var _shot_side_script: GDScript
onready var _shot_side_instance = _shot_side_script.new()
export(GDScript) var _velocity_script: GDScript
onready var _velocity_instance = _velocity_script.new()

signal deactivate(side_index)

var _side_index := -1 # G.Sides
var _is_active := false

onready var _collision_node := $Collision as CollisionShape2D
onready var _player_shot_node := $PlayerShot as PlayerShot
onready var _body_node := $Body as Polygon2D
onready var _destroy_node := $Destroy as Particles2D
onready var _destroyed_node := $Destroyed as AudioStreamPlayer2D

func set_side_index(side_index: int) -> void:
    _side_index = side_index

func shot_side(side_index: int) -> void:
    if _is_active and Input.is_action_just_pressed(_shot_side_instance.get_shot_side(side_index)):
        _player_shot_node.shot(_velocity_instance.get_velocity(side_index), modulate)

func _on_PlayerGun_area_entered(area_node: Area2D) -> void:
    if not GState.status_is_jumping:
        if area_node is BulletArea2D:
            _can_deactivate(area_node as BulletArea2D)
        elif area_node is EnemyNeedles:
            _deactivate()

func _can_deactivate(bullet_area2d_node: BulletArea2D) -> void:
    var bullet_node := bullet_area2d_node.get_parent() as CommonBullet
    if bullet_node.modulate == modulate or bullet_node.modulate == GColor.WHITE:
        _deactivate()

func _deactivate() -> void:
    _hide_from_level()
    _hide_with_effect()
    _emit_deactivate()
    _destroyed_node.play()

func deactivate_from_weapon() -> void:
    _hide_from_level()
    _emit_deactivate()

func _hide_from_level() -> void:
    _is_active = false
    _disable_collision(true)
    _body_node.hide()

func _hide_with_effect() -> void:
    _destroy_node.emitting = true

func _emit_deactivate() -> void:
    _set_color_weapon_gun(GColor.DARK) # Для HUDArrows - различать уничтожение пушки от перезарядки.
    emit_signal('deactivate', _side_index)

func _disable_collision(is_disabled: bool) -> void:
    _collision_node.set_deferred('disabled', is_disabled)

func activate() -> void:
    _is_active = true
    _disable_collision(false)
    _body_node.show()
    _set_color_weapon_gun(modulate)

func _on_PlayerShot_is_cooldown(is_cooldown: bool) -> void:
    if is_cooldown:
        _body_node.modulate = GColor.BLACK
        _set_color_weapon_gun(GColor.BLACK)
    else:
        _body_node.modulate = GColor.WHITE
        _set_color_weapon_gun(modulate)

func _set_color_weapon_gun(color: Color) -> void:
    GState.colors_weapon_guns[_side_index] = color
