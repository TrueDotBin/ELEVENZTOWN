extends Control

@export var unlock_screen_name: String

func on_home_pressed(phone: Phone):
	var tween = TweenManager.create(self, Tween.EASE_OUT, Tween.TRANS_CIRC)
	tween.tween_property(self, "position:y", -size.y, 0.35)
	tween.finished.connect(phone.show_screen.bind(unlock_screen_name))