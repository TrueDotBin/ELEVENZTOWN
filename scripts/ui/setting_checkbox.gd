extends Control

@export var setting_label: String
@export var setting: String

@onready var check_btn: CheckButton = $CheckButton

func _ready() -> void:
	check_btn.text = setting_label

	check_btn.button_pressed = SettingsManager.settings.get(setting)
	check_btn.toggled.connect(_toggled)

func _toggled(new_state: bool):
	SettingsManager.settings.set(setting, new_state)	
