extends Node

var _tweens: Dictionary[Node, Tween] = {}

func create(node: Node, ease_type: Tween.EaseType, trans_type: Tween.TransitionType, parallel: bool = false) -> Tween:
    if node in _tweens:
        var old_tween = _tweens[node]
        
        if old_tween.is_valid():
            old_tween.kill()
    
    var tween = node.create_tween()

    tween.set_ease(ease_type)
    tween.set_trans(trans_type)
    tween.set_parallel(parallel)

    _tweens[node] = tween

    return tween