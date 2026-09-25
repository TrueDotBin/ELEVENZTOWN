extends Control

@export var main_menu_song: AudioStream = AudioLibrary.MENU_SONG

@onready var credits_panel: CreditsPanel = $CreditsPanel

@onready var play_button: Button = $ButtonContainer/PlayButton
@onready var options_button: Button = $ButtonContainer/OptionsButton
@onready var credits_button: Button = $ButtonContainer/CreditsButton
@onready var leave_button: Button = $ButtonContainer/LeaveButton

func _connect_button_signals() -> void:
	leave_button.pressed.connect(GameManager.quit_game)
	credits_button.pressed.connect(credits_panel.show)
	options_button.pressed.connect(GameManager.show_options)
	play_button.pressed.connect(GameManager.start_game)

func _ready() -> void:
	AudioManager.play_music(main_menu_song)

	play_button.grab_focus()

	if OS.has_feature("mobile") or OS.has_feature("web"):
		leave_button.hide()

	_connect_button_signals()