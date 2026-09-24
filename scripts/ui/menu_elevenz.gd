extends TextureRect

@export var scale_speed: float = 3
@export var scale_amount: float = 0.015

var _time: float
var _start_scale_y: float

func _ready() -> void:
	_start_scale_y = scale.y

func _process(delta: float) -> void:
	_time += delta
	scale.y = _start_scale_y + sin(_time * scale_speed) * scale_amount
