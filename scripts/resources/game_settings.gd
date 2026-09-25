class_name GameSettings
extends Resource

@export_category("Audio")
@export var master_volume: float = 1.0
@export var music_volume: float = 1.0
@export var sfx_volume: float = 1.0

@export_category("Video")
@export var fullscreen: bool = true
@export var vsync: bool = true
@export var ui_scale: float = 1.0

func _apply_video_settings(root: Window) -> void:
    var window_mode = DisplayServer.WINDOW_MODE_FULLSCREEN if fullscreen else DisplayServer.WINDOW_MODE_WINDOWED
    var vsync_mode = DisplayServer.VSYNC_ENABLED if vsync else DisplayServer.VSYNC_DISABLED

    DisplayServer.window_set_mode(window_mode)
    DisplayServer.window_set_vsync_mode(vsync_mode)

    root.content_scale_factor = ui_scale

func _set_volume(master_bus_idx: int, music_bus_idx: int, sfx_bus_idx: int) -> void:
    AudioServer.set_bus_volume_linear(master_bus_idx, master_volume)
    AudioServer.set_bus_volume_linear(music_bus_idx, music_volume)
    AudioServer.set_bus_volume_linear(sfx_bus_idx, sfx_volume)

func apply(root: Window, master_bus_idx: int, music_bus_idx: int, sfx_bus_idx: int) -> void:
    print("[Game Settings] Applying changes")
    
    _apply_video_settings(root)
    _set_volume(master_bus_idx, music_bus_idx, sfx_bus_idx)