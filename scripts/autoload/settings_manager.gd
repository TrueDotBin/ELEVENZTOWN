extends Node

const PATH: String = "user://settings.tres"
const DEFAULT_PATH: String = "res://resources/default_settings.tres"

var settings: GameSettings

func _ready() -> void:
	load_settings()
	apply_settings()

func load_settings() -> void:
	if ResourceLoader.exists(PATH):
		print("[Settings Manager] Loading user settings")
		settings = ResourceLoader.load(PATH) as GameSettings
	else:
		print("[Settings Manager] Loading default settings")
		settings = ResourceLoader.load(DEFAULT_PATH).duplicate() as GameSettings

func save_settings() -> void:
	if not settings:
		load_settings()

	print("[Settings Manager] Saving settings")
	
	ResourceSaver.save(settings, PATH)

func reset_to_defaults() -> void:
	print("[Settings Manager] Loading default settings")
	settings = ResourceLoader.load(DEFAULT_PATH).duplicate() as GameSettings

func apply_settings() -> void:
	var root = get_tree().root
	settings.apply(root)
