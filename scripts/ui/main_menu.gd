extends Control

@export var main_menu_song: AudioStream = AudioLibrary.MENU_SONG

@onready var play_button = $ButtonContainer/PlayButton
@onready var options_button = $ButtonContainer/OptionsButton
@onready var credits_button = $ButtonContainer/CreditsButton
@onready var leave_button = $ButtonContainer/LeaveButton

func _ready() -> void:
	AudioManager.play_music(main_menu_song)

	if OS.has_feature("mobile") or OS.has_feature("web"):
		leave_button.hide()