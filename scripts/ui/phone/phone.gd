extends TextureRect
class_name Phone

@export_category("Screens")
@export var start_screen_name: String
@export var screens: Dictionary[String, Control] = {}

var _current_screen: Control

func _hide_all_screens():
	for screen in screens.values():
		screen.hide()

func show_screen(screen_name: String) -> void:
	var screen = screens.get(screen_name)

	if not screen:
		push_error("[Phone] Cannot show screen %s because it doesn't exist" % screen_name)
		return

	if _current_screen:
		_current_screen.hide()

	_current_screen = screen
	screen.show()

func _ready() -> void:
	_hide_all_screens()
	show_screen(start_screen_name)

func _on_home_button_pressed() -> void:
	if _current_screen and _current_screen.has_method("on_home_pressed"):
		_current_screen.on_home_pressed(self)