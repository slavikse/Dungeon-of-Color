extends Node2D
class_name EnemyGun

var _texture_color: Color
var _player_body_node: PlayerBody

onready var _enemy_shot_node := $EnemyShot as EnemyShot
onready var _shooting_detector_keep_shooting_node := $ShootingDetector/KeepShooting as Timer

func set_texture_color(color: Color) -> void:
    _texture_color = color

func _on_Detector_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _shoot_player(area_node as PlayerBody)
        _shooting_detector_keep_shooting_node.start()

func _on_KeepShooting_timeout() -> void:
    _shoot_player(_player_body_node)

func _shoot_player(player_body_node: PlayerBody) -> void:
    _player_body_node = player_body_node
    if _has_player_visible(player_body_node.global_position):
        _enemy_shot_node.shot(_texture_color)

func _has_player_visible(player_body_global_position: Vector2) -> bool:
    var collision := G.world_node.direct_space_state.intersect_ray(
        global_position, player_body_global_position, [self], GNumber.PLAYER_WALL_COLLISON_MASK)
    return collision and collision.collider is Player

func _on_Detector_area_exited(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _shooting_detector_keep_shooting_node.stop()
