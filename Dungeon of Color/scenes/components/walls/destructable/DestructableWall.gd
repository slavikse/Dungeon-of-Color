extends StaticBody2D

enum _Colors { RED, GREEN, BLUE, YELLOW } # Должно соответствовать с порядком в _COLORS
export(_Colors) var _color_index := _Colors.RED

onready var _collision_node := $Collision as CollisionShape2D
onready var _body_node := $Body as Polygon2D
onready var _common_wall_node := $CommonWall as Area2D
onready var _destroy_node := $Destroy as Particles2D
onready var _destroyed_node := $Destroyed as AudioStreamPlayer2D

func _ready() -> void:
    _set_wall_color()

func _set_wall_color() -> void:
    _body_node.modulate = GColor.get_color(_color_index)
    _destroy_node.modulate = _body_node.modulate

func _on_Wall_area_entered(area_node: Area2D) -> void:
    if area_node is BulletArea2D:
        _checking_destruction(area_node.get_parent())
    elif area_node is PlayerNeedle:
        _wall_destroy()
    elif area_node is EnemyNeedles:
        _wall_destroy()

func _checking_destruction(bullet_node: CommonBullet) -> void:
    if bullet_node.modulate == _body_node.modulate:
        _wall_destroy()

func _wall_destroy() -> void:
    _remove_object_from_level()
    _remove_object_with_effect()
    _destroyed_node.play()

func _remove_object_from_level() -> void:
    _collision_node.set_deferred('disabled', true)
    _body_node.hide()
    _common_wall_node.queue_free()

func _remove_object_with_effect() -> void:
    _destroy_node.emitting = true
    GFunc.timer_start(_destroy_node.lifetime, self, '_destroy_ended')

func _destroy_ended(timer_node: Timer) -> void:
    timer_node.queue_free()
    queue_free()
