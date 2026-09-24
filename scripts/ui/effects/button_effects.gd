extends Button

@export_category("Sound Effects")
@export var button_down_sound: AudioStream = AudioLibrary.BUTTON_DOWN
@export var button_up_sound: AudioStream = AudioLibrary.BUTTON_UP

@export_category("Tweening")
@export var tween_duration: float = 0.35
@export var btn_hover_scale: float = 0.05
@export var btn_hover_rotation: float = 1.25
@export var btn_press_scale: float = 0.035
@export var trans_type: Tween.TransitionType = Tween.TRANS_QUINT

var _tween: Tween
var _start_scale: Vector2

func _ready() -> void:
    pivot_offset_ratio = Vector2(0.5, 0.5)
    _start_scale = scale

    button_down.connect(_btn_down)
    button_up.connect(_btn_up)
    mouse_entered.connect(_mouse_enter)
    mouse_exited.connect(_reset_props)

func _mouse_enter() -> void:
    var new_scale_x = _start_scale.x + btn_hover_scale
    var new_scale_y = _start_scale.y + btn_hover_scale
    var new_scale = Vector2(new_scale_x, new_scale_y)

    _tween = TweenManager.create(self, Tween.EASE_OUT, trans_type, true)
    _tween.tween_property(self, "scale", new_scale, tween_duration)
    _tween.tween_property(self, "rotation_degrees", btn_hover_rotation, tween_duration)

func _reset_props() -> void:
    _tween = TweenManager.create(self, Tween.EASE_OUT, trans_type, true)
    _tween.tween_property(self, "scale", _start_scale, tween_duration)
    _tween.tween_property(self, "rotation_degrees", 0, tween_duration)

func _btn_down() -> void:
    var new_scale_x = _start_scale.x - btn_press_scale
    var new_scale_y = _start_scale.y - btn_press_scale
    var new_scale = Vector2(new_scale_x, new_scale_y)

    _tween = TweenManager.create(self, Tween.EASE_OUT, trans_type, true)
    _tween.tween_property(self, "scale", new_scale, tween_duration)
    _tween.tween_property(self, "rotation_degrees", 0, tween_duration)

    AudioManager.play_sound(button_down_sound)

func _btn_up() -> void:
    _reset_props()

    AudioManager.play_sound(button_up_sound)