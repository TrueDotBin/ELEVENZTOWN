extends TextureRect

@export var rotation_speed: float = 3
@export var rotation_amplitude: float = 1.5

var _time: float

func _process(delta: float) -> void:
	_time += delta

	rotation_degrees = sin(_time * rotation_speed) * rotation_amplitude
