extends Node

enum GameState {
    IN_MENU,
    PLAYING
}

var state: GameState = GameState.IN_MENU

func _ready() -> void:
    print("WELCOME TO ELEVENZTOWN!")

func quit_game() -> void:
    print("[ELEVENZTOWN] Quitting...")
    get_tree().quit()