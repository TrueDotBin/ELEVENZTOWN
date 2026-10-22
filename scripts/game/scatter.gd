extends Node3D

@export var amount: int = 100
@export var area: Vector2 = Vector2(50, 50)

@export_category("3D Models")
@export var models: Array[PackedScene] = []
@export var min_size: float = 2.5
@export var max_size: float = 7

func _ready() -> void:
	_scatter_models()

func _scatter_models() -> void:
	for child in get_children():
		child.queue_free()

	for i in amount:
		_spawn_model()

func _spawn_model() -> void:
	if models.is_empty():
		return

	var model = models.pick_random()
	var instance: Node3D = model.instantiate()

	var pos = Vector3(
		randf_range(-area.x / 2, area.x / 2),
		randf_range(0, -0.45),
		randf_range(-area.y / 2, area.y / 2)
	)

	instance.position = pos

	var rand_scale = Vector3.ONE * randf_range(min_size, max_size)
	instance.scale = rand_scale

	add_child(instance)
