extends Node2D

enum Sides { UP, RIGHT, DOWN, LEFT }
enum Gunman { PLAYER, ENEMY }

const _LEVELS_FILE_NAME := "user://Dungeon_of_Color.pixsynt"

onready var _scene_tree := get_tree() as SceneTree

#warning-ignore:UNUSED_CLASS_VARIABLE
onready var root_node := $'/root' as Viewport
#warning-ignore:UNUSED_CLASS_VARIABLE
onready var world_node := get_world_2d() as World2D

func scene_paused(flag: bool) -> void:
    _scene_tree.paused = flag
