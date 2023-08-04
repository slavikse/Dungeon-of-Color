extends KinematicBody2D
class_name Enemy

onready var _collision_node := $Collision as CollisionShape2D
onready var _enemy_body_node := $EnemyBody as EnemyBody
onready var _enemy_hp_node := $EnemyHP as Node2D
onready var _enemy_gun_node := $EnemyGun as EnemyGun
onready var _make_node := $Make as Particles2D
onready var _destroy_node := $Destroy as Particles2D
onready var _destroyed_node := $Destroyed as AudioStreamPlayer2D

func _ready() -> void:
    _set_colors()
    _creature()
    _random_rotate()

func _set_colors() -> void:
    var color := GColor.get_random_color()
    _enemy_body_node.set_texture_color(color)
    _enemy_gun_node.set_texture_color(color)
    _colour_particles(color)

func _colour_particles(color: Color) -> void:
    _make_node.modulate = color
    _destroy_node.modulate = color

func _creature() -> void:
    _enemy_body_node.hide()
    _make_node.emitting = true
    GFunc.timer_start(_make_node.lifetime, self, '_make_ended')

func _make_ended(timer_node: Timer) -> void:
    timer_node.queue_free()
    if is_instance_valid(_enemy_body_node):
        _enemy_body_node.show()

func _random_rotate() -> void:
    rotation_degrees = GNumber.get_random_forward_angle()

func _on_EnemyBody_apply_movement_velocity(velocity: Vector2) -> void:
    #warning-ignore:RETURN_VALUE_DISCARDED
    move_and_slide(velocity)

func _on_EnemyBody_change_direction_degrees(degree: int) -> void:
    rotation_degrees = degree
    _enemy_hp_node.rotation_degrees = -degree

func _on_EnemyBody_check_enemy_destroyed(bullet_node: CommonBullet) -> void:
    if bullet_node.get_gunman() == int(G.Gunman.PLAYER):
        _check_destroyed(bullet_node.modulate, _enemy_body_node.get_body_modulate())

func _check_destroyed(bullet_modulate: Color, enemy_modulate: Color) -> void:
    if bullet_modulate == enemy_modulate:
        _enemy_destroy()

func _on_EnemyBody_enemy_destroyed() -> void:
    _enemy_destroy()

func _enemy_destroy() -> void:
    _remove_from_level()
    _remove_with_effect()
    _destroyed_node.play()

func _remove_from_level() -> void:
    _collision_node.set_deferred('disabled', true)
    _enemy_body_node.queue_free()
    _enemy_gun_node.queue_free()

func _remove_with_effect() -> void:
    _destroy_node.emitting = true
    GFunc.timer_start(_destroy_node.lifetime, self, '_destroy_ended')

func _destroy_ended(timer_node: Timer) -> void:
    timer_node.queue_free()
    queue_free()
