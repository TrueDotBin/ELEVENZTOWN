extends Label

func _ready() -> void:
	var project_version = ProjectSettings.get_setting("application/config/version")
	text = project_version