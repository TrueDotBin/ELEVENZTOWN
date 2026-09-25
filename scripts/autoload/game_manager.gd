extends Node

enum GameState {
    IN_MENU,
    PLAYING
}

var state: GameState = GameState.IN_MENU

func _ready() -> void:
    print("WELCOME TO ELEVENZTOWN!")

    OverlayManager.add_overlay("options", OverlayLibrary.SETTINGS)

func _notification(what: int) -> void:
    if what == NOTIFICATION_WM_CLOSE_REQUEST:
        _quit()

func quit_game() -> void:
    print("[ELEVENZTOWN] Quitting...")
    _quit()

func _quit() -> void:
    SettingsManager.save_settings()
    get_tree().quit()

func show_options() -> void:
    OverlayManager.show_overlay("options")