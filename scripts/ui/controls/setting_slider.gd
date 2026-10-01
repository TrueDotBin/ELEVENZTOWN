extends Control

@export var setting_label: String
@export var setting: String

@export_category("Values")
@export var min_value: float = 0.0
@export var max_value: float = 1.0

@onready var label: Label = $Container/Label
@onready var slider: HSlider = $Container/Slider

func _ready() -> void:
	label.text = setting_label

	slider.min_value = min_value
	slider.max_value = max_value
	slider.value = SettingsManager.settings.get(setting)
	slider.drag_ended.connect(_value_changed)

func _value_changed(has_changed: bool):
	if has_changed:
		SettingsManager.settings.set(setting, slider.value)	
