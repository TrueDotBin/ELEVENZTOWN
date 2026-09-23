extends Node

@onready var sound_player: AudioStreamPlayer = $SoundPlayer
@onready var music_player: AudioStreamPlayer = $MusicPlayer

func play_sound(stream: AudioStream, pitch: float = 1.0, volume: float = 1.0):
    sound_player.stream = stream
    sound_player.pitch_scale = pitch
    sound_player.volume_linear = volume

    sound_player.play()

func play_sound_and_wait(stream: AudioStream, pitch: float = 1.0, volume: float = 1.0):
    play_sound(stream, pitch, volume)

    await sound_player.finished

func play_music(stream: AudioStream, volume: float = 1.0):
    music_player.stream = stream
    music_player.volume_linear = volume

    music_player.play()