extends Control

@export var main_menu_song: AudioStream = AudioLibrary.MENU_SONG

func _ready() -> void:
	AudioManager.play_music(main_menu_song)