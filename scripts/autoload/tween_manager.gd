extends Node

func create(node: Node, ease_type: Tween.EaseType, trans_type: Tween.TransitionType, parallel: bool = false) -> Tween:	
	var tween = node.create_tween()
	tween.set_ease(ease_type)
	tween.set_trans(trans_type)
	tween.set_parallel(parallel)
	return tween