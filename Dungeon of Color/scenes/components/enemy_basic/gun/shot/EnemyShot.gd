extends Node2D
class_name EnemyShot

export(GDScript) var _velocity_script: GDScript
onready var _velocity_instance = _velocity_script.new()
export(GDScript) var _degree_target_script: GDScript
onready var _degree_target_instance = _degree_target_script.new()

export(PackedScene) var _common_bullet_scene: PackedScene

onready var _bullet_direction_node := $BulletDirection as Position2D
onready var _fired_node := $Fired as Particles2D

func shot(color: Color) -> void:
    call_deferred('_shot_deferred', color)
    _emitting_fire(color)

func _shot_deferred(color: Color) -> void:
    var bullet_node := _common_bullet_scene.instance() as CommonBullet
    var velocity := _get_shot_velocity()
    bullet_node.setup(_bullet_direction_node.global_position, color)\
        .launch(int(G.Gunman.ENEMY), velocity)

func _get_shot_velocity() -> Vector2:
    var target_direction := int(_degree_target_instance.get_target_direction(
        global_position, _bullet_direction_node.global_position))
    return _velocity_instance.get_velocity_immutable(target_direction)

func _emitting_fire(color: Color) -> void:
    _fired_node.modulate = color
    _fired_node.emitting = true
