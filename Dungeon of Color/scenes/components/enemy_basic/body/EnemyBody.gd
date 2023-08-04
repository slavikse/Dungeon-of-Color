extends Area2D
class_name EnemyBody

export(GDScript) var _velocity_direction_script: GDScript
onready var _velocity_direction_instance = _velocity_direction_script.new()
export(GDScript) var _degree_target_script: GDScript
onready var _degree_target_instance = _degree_target_script.new()

signal apply_movement_velocity(velocity)
signal change_direction_degrees(degree)
signal check_enemy_destroyed(bullet_node)
signal enemy_destroyed()

const _NORMAL_MOVEMENT_SPEED := 80
const _ACCELERATED_MOVEMENT_SPEED := int(_NORMAL_MOVEMENT_SPEED * 2)

var _movement_speed := _NORMAL_MOVEMENT_SPEED
var _is_player_detected := false
var _player_position := Vector2.ZERO
var _movement_velocity := Vector2.ZERO
var _is_angry := false

onready var _enemy_needles_node := $EnemyNeedles as EnemyNeedles
onready var _body_node := $Body as Polygon2D
onready var _body_evil_node := $Body/Evil as Node2D
onready var _stomp_node := $Stomp as AudioStreamPlayer2D
onready var _angry_node := $Angry as AudioStreamPlayer2D

func set_texture_color(color: Color) -> void:
    _body_node.modulate = color

func _physics_process(_delta: float) -> void:
    emit_signal('apply_movement_velocity', _movement_velocity)

func _on_ChangeDirection_timeout() -> void:
    if _is_player_detected:
        _head_to_player()
    else:
        _wander_random_directions()

    if _movement_velocity != Vector2.ZERO:
        if not _stomp_node.playing and _is_angry:
            _stomp_node.play()

func _head_to_player() -> void:
    var target_degree := int(_degree_target_instance.get_random_degree_target(_player_position, global_position))
    _movement_velocity = _velocity_direction_instance.get_target_velocity_direction(target_degree, _movement_speed)
    emit_signal('change_direction_degrees', target_degree)

func _wander_random_directions() -> void:
    _movement_velocity = _velocity_direction_instance.get_random_velocity_direction(_movement_speed)
    var movement_degree := int(_degree_target_instance.get_movement_degree(_movement_velocity))
    emit_signal('change_direction_degrees', movement_degree)

func get_body_modulate() -> Color: return _body_node.modulate

func _on_EnemyFieldView_check_player_visibility(player_position: Vector2) -> void:
    _player_position = player_position
    _is_player_detected = not G.world_node.direct_space_state.intersect_ray(
        _player_position, global_position, [self], GNumber.WALL_COLLISON_MASK)
    _change_movement_speed()
    _switch_eyes()

func _change_movement_speed() -> void:
    if _is_player_detected:
        _movement_speed = _ACCELERATED_MOVEMENT_SPEED
    else:
        _movement_speed = _NORMAL_MOVEMENT_SPEED

func _switch_eyes() -> void:
    if _is_player_detected:
        _body_evil_node.show()
        _enemy_needles_node.activate()

        if not _is_angry:
            _angry_node.play()
            _is_angry = true
    else:
        _body_evil_node.hide()
        _enemy_needles_node.deactivate()
        _is_angry = false

func _on_EnemyBody_area_entered(area_node: Area2D) -> void:
    if area_node is BulletArea2D:
        var bullet_node := (area_node as BulletArea2D).get_parent() as CommonBullet
        emit_signal('check_enemy_destroyed', bullet_node)
    elif area_node is PlayerNeedle:
        enemy_destroyed()

func enemy_destroyed() -> void:
    emit_signal('enemy_destroyed')
