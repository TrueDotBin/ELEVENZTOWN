extends Control

func _on_video_finished() -> void:
	SceneManager.change_scene("res://scenes/ui/main_menu.tscn")