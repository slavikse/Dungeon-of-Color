extends Node2D
class_name PlayerShot

export(PackedScene) var _common_bullet_scene: PackedScene

signal is_cooldown(is_cooldown)

onready var _bullet_direction_node := $BulletDirection as Position2D
onready var _fired_node := $Fired as Particles2D
onready var _common_timer_node := $CommonTimer as CommonTimer

func _process(_delta: float) -> void:
    if not GState.status_is_weapon and not _common_timer_node.has_timeout():
        _common_timer_node.stop()

func shot(velocity: Vector2, color: Color) -> void:
    if _common_timer_node.has_timeout():
        _create_bullet(velocity, color)
        emit_signal('is_cooldown', true)
        _common_timer_node.start(GState.delay_shot_cooldown)

func _create_bullet(velocity: Vector2, color: Color) -> void:
    var bullet_node := _common_bullet_scene.instance() as CommonBullet
    bullet_node.setup(_bullet_direction_node.global_position, color)\
        .launch(int(G.Gunman.PLAYER), velocity)
    _fired_node.emitting = true

func _on_CommonTimer_timeout() -> void:
    emit_signal('is_cooldown', false)
