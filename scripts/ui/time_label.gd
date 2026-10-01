extends Label

func _process(_delta: float) -> void:
	var time_dict = Time.get_time_dict_from_system()
	text = "%02d:%02d" % [time_dict.hour, time_dict.minute]
