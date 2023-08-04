extends Node2D

const WHITE := Color('#fafafa') # Преобладающий цвет текстур для смешивания.
const BLACK := Color('#111111') # Объекты нельзя разрушить.
const DARK := Color('#212121') # Для отличия от BLACK.

const RED := Color('#ef5350')
const GREEN := Color('#43a047')
const BLUE := Color('#1976d2')
const YELLOW := Color('#ffeb3b')

const _COLORS := [RED, GREEN, BLUE, YELLOW]
const _COLORS_IMMUTABLE := [RED, GREEN, BLUE, YELLOW]

func _ready() -> void:
    randomize()
    _COLORS.shuffle()

func get_random_color() -> Color:
    var color_index := GNumber.get_random_range_int(0, len(_COLORS) - 1)
    return Color(_COLORS[color_index])

func get_color(index: int) -> Color:
    return Color(_COLORS_IMMUTABLE[index])
