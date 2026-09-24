class_name GameSettings
extends Resource

@export_category("Audio")
@export var master_volume: float = 1.0
@export var music_volume: float = 1.0
@export var sfx_volume: float = 1.0

@export_category("Video")
@export var window_mode: DisplayServer.WindowMode = DisplayServer.WINDOW_MODE_FULLSCREEN
@export var vsync_mode: DisplayServer.VSyncMode = DisplayServer.VSYNC_ENABLED
@export var ui_scale: float = 1.0
@export var msaa: Viewport.MSAA = Viewport.MSAA_DISABLED

var master_bus: StringName = "Master"
var music_bus: StringName = "Music"
var sfx_bus: StringName = "Sound"

var _master_bus_idx: int
var _music_bus_idx: int
var _sfx_bus_idx: int

func _ready() -> void:
    _master_bus_idx = AudioServer.get_bus_index(master_bus)
    _music_bus_idx = AudioServer.get_bus_index(music_bus)
    _sfx_bus_idx = AudioServer.get_bus_index(sfx_bus)

func _apply_video_settings(root: Window) -> void:
    DisplayServer.window_set_mode(window_mode)
    DisplayServer.window_set_vsync_mode(vsync_mode)

    root.msaa_2d = msaa
    root.content_scale_factor = ui_scale

func _set_volume() -> void:
    AudioServer.set_bus_volume_linear(_master_bus_idx, master_volume)
    AudioServer.set_bus_volume_linear(_music_bus_idx, music_volume)
    AudioServer.set_bus_volume_linear(_sfx_bus_idx, sfx_volume)

func apply(root: Window) -> void:
    print("[Game Settings] Applying changes")
    
    _apply_video_settings(root)
    _set_volume()