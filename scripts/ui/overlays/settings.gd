extends CanvasLayer

func _on_close_settings_button_pressed() -> void:
	SettingsManager.apply_settings()
	hide()
