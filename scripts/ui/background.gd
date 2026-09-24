extends TextureRect

@export var movement_speed: float = 0.2
@export var movement_strength: float = 3

var _time: float
var _start_x: float

func _ready() -> void:
	_start_x = position.x

func _process(delta: float) -> void:
	_time += delta

	position.x = _start_x + sin(_time * movement_speed) * movement_strength