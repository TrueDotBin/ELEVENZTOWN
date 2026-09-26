extends Node3D

@export var amount: int = 100
@export var area: Vector2 = Vector2(50, 50)

@export_category("3D Models")
@export var trees: Array[PackedScene] = []
@export var min_size: float = 2.5
@export var max_size: float = 7

func _ready() -> void:
	_create_trees()

func _create_trees() -> void:
	for child in get_children():
		child.queue_free()

	for i in amount:
		_spawn_tree()

func _spawn_tree() -> void:
	if trees.is_empty():
		return

	var tree = trees.pick_random()
	var instance: Node3D = tree.instantiate()

	var pos = Vector3(
		randf_range(-area.x / 2, area.x / 2),
		0,
		randf_range(-area.y / 2, area.y / 2)
	)
	instance.position = pos

	var tree_scale = Vector3.ONE * randf_range(min_size, max_size)
	instance.scale = tree_scale

	instance.rotation.y = randi() * TAU

	add_child(instance)
