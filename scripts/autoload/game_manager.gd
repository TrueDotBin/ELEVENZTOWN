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

func start_game() -> void:
    state = GameState.PLAYING
    SceneManager.change_scene("res://scenes/game/game.tscn")

func return_to_menu() -> void:
    state = GameState.IN_MENU
    SceneManager.change_scene("res://scenes/ui/main_menu.tscn")