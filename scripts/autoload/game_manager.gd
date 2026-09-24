extends Node

enum GameState {
    IN_MENU,
    PLAYING
}

var state: GameState = GameState.IN_MENU

func quit_game() -> void:
    get_tree().quit()