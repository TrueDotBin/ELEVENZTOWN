extends Node

const PATH: String = "user://settings.tres"
const DEFAULT_PATH: String = "res://resources/default_settings.tres"

var settings: GameSettings

var master_bus: StringName = "Master"
var music_bus: StringName = "Music"
var sfx_bus: StringName = "Sound"

var _master_bus_idx: int
var _music_bus_idx: int
var _sfx_bus_idx: int

func _ready() -> void:
	load_settings()
	apply_settings()

	_master_bus_idx = AudioServer.get_bus_index(master_bus)
	_music_bus_idx = AudioServer.get_bus_index(music_bus)
	_sfx_bus_idx = AudioServer.get_bus_index(sfx_bus)

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
	settings.apply(root, _master_bus_idx, _music_bus_idx, _sfx_bus_idx)
