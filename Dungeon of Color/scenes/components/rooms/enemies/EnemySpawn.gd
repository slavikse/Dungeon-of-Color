extends Node2D
class_name EnemySpawn

export(PackedScene) var _enemy_basic_scene: PackedScene

onready var _spawn_nodes := get_children() as Array # Размещены на уровне.

func create_enemies() -> void:
    for spawn_node in _spawn_nodes:
        var enemy_basic_node := _create_enemy_basic(spawn_node)
        G.root_node.call_deferred('add_child', enemy_basic_node)

func _create_enemy_basic(spawn_node: Position2D) -> Enemy:
    var enemy_basic_node := _enemy_basic_scene.instance() as Enemy
    enemy_basic_node.position = spawn_node.global_position
    return enemy_basic_node

func enemy_destroyed(enemy_body_node: EnemyBody) -> void:
    enemy_body_node.enemy_destroyed()
