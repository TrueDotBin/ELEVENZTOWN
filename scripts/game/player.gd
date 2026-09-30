extends CharacterBody3D

enum PlayerState {
	NONE,
	USING_ITEM
}

@export_category("Movement")
@export var speed = 12.0
@export var jump_velocity = 9.5

@export_category("First-Person Camera")
@export var camera: Camera3D
@export var sensitivity: float = 0.005

@export_category("Interact")
@export var interact_range: float = 2.5

var state: PlayerState = PlayerState.NONE

func has_no_state() -> bool:
	return state == PlayerState.NONE

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and has_no_state():
		rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -PI / 2, PI / 2)
		
func _ray() -> void:
	var space_state = get_world_3d().direct_space_state

	var from = camera.global_position
	var to = from + (-camera.global_transform.basis.z) * interact_range
	var query = PhysicsRayQueryParameters3D.create(from, to)
	var result = space_state.intersect_ray(query)

	if result.is_empty():
		return

	var aimed = result.collider

	if aimed.is_in_group("usable"):
		if Input.is_action_just_pressed("use") and aimed.has_method("use"):
			state = PlayerState.USING_ITEM
			
			aimed.use()
			aimed.stopped.connect(func():
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
				state = PlayerState.NONE
			)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if has_no_state():
		if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity

		var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
		var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed

		move_and_slide()

	_ray()
