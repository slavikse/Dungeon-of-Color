extends Area2D

signal rotate_right()

const _SHUTDOWN_TIME := 0.2 # > 0.16ms

onready var _collision_node := $Collision as CollisionShape2D
onready var _fog_of_war_node := $FogOfWar as Polygon2D
onready var _enemy_spawn_node := $EnemySpawn as EnemySpawn
onready var _create_enemies_node := $CreateEnemies as AudioStreamPlayer

func _ready() -> void:
    _fog_of_war_node.show()

func _on_Room_area_entered(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _fog_of_war_node.hide()
        _enemy_spawn_node.create_enemies()
    _create_enemies_node.play()

func _on_Room_area_exited(area_node: Area2D) -> void:
    if area_node is PlayerBody:
        _collision_shutdown()
        _fog_of_war_node.show()
    elif area_node is EnemyBody:
        _enemy_spawn_node.enemy_destroyed(area_node)

func _collision_shutdown() -> void:
    _collision_toggle(true)
    GFunc.timer_start(_SHUTDOWN_TIME, self, '_collision_shutdown_timeout')

func _collision_toggle(is_disabled: bool) -> void:
    _collision_node.set_deferred('disabled', is_disabled)

func _collision_shutdown_timeout(timer_node: Timer) -> void:
    timer_node.queue_free()
    _collision_toggle(false)

func _on_WeaponTurn_rotate_right() -> void:
    emit_signal('rotate_right')
