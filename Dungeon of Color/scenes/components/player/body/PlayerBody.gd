extends Area2D
class_name PlayerBody

export(GDScript) var _shot_side_script: GDScript
onready var _shot_side_instance = _shot_side_script.new()
export(GDScript) var _velocity_script: GDScript
onready var _velocity_instance = _velocity_script.new()

var _previous_velocity := Vector2.ZERO

onready var _collision_node := $Collision as CollisionPolygon2D
onready var _body_node := $Body as Polygon2D
onready var _body_player_eye_node := $Body/PlayerEye as PlayerEye
onready var _player_needles_node := $PlayerNeedles as PlayerNeedles
onready var _destroy_node := $Destroy as Particles2D
onready var _destroyed_node := $Destroyed as AudioStreamPlayer2D
onready var _game_over_node := $GameOver as Node2D
onready var _game_end_node := $GameEnd as Node2D

func _ready() -> void:
    _body_node.modulate = GColor.WHITE

func activate_needles(side_index: int) -> void:
    if is_instance_valid(_player_needles_node):
        _player_needles_node.activate(side_index)

func eye_movement(velocity: Vector2) -> void:
    if _previous_velocity != velocity:
        if is_instance_valid(_body_player_eye_node):
            _body_player_eye_node.movement(velocity)
    _previous_velocity = velocity

func rotate_left(rotate_to: int) -> void:
    for _i in float(rotate_to) / GNumber.RIGHT_ANGLE:
        _rotate_left()

func _rotate_left() -> void:
    _body_rotate_left()
    _player_needles_node.rotate_left()
    _shot_side_instance.turn_weapon_right()
    _velocity_instance.turn_velocities_right()

func _body_rotate_left() -> void:
    _body_node.rotation_degrees -= GNumber.RIGHT_ANGLE
    GState.player_rotation_degrees = _body_node.rotation_degrees
    _game_over_node.rotation_degrees -= GNumber.RIGHT_ANGLE

func _on_PlayerBody_area_entered(area_node: Area2D) -> void:
    if area_node is BulletArea2D or area_node is EnemyNeedles:
        _game_over()

func _game_over() -> void:
    _game_end()
    _game_over_node.show()

func game_end() -> void:
    _game_end()
    _game_end_node.show()

func _game_end() -> void:
    GState.player_is_game_over = true
    _hide_from_level()
    _hide_with_effect()
    _destroyed_node.play()

func _hide_from_level() -> void:
    _collision_node.set_deferred('disabled', true)
    _body_node.queue_free()
    _player_needles_node.queue_free()

func _hide_with_effect() -> void:
    _destroy_node.emitting = true
    GFunc.timer_start(_destroy_node.lifetime, self, '_destroy_ended')

func _destroy_ended(timer_node: Timer) -> void:
    timer_node.queue_free()

func _on_PlayerWeapon_is_needles_active(is_active: bool) -> void:
    if is_active:
        _player_needles_node.show()
        _body_player_eye_node.increase()
    else:
        _player_needles_node.hide()

func _on_Start_pressed() -> void:
    GState.player_is_game_over = false
    GState.reset_pumping()
    _shot_side_instance.reset_shot_sides()
    _velocity_instance.reset_velocities_mutable()
    #warning-ignore:RETURN_VALUE_DISCARDED
    get_tree().change_scene("res://scenes/levels/level_01/Level_01.tscn")

func _on_Exit_pressed() -> void:
    get_tree().quit()
