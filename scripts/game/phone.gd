extends StaticBody3D

@export var phone_ui: Control

signal stopped()

func use() -> void:
	phone_ui.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	print("[Phone] use() called")

func stop_using() -> void:
	phone_ui.hide()
	stopped.emit()