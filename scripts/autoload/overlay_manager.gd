extends Node

var _overlays: Dictionary[String, Node] = {}

func add_overlay(key: String, packed: PackedScene) -> Node:
    if key in _overlays:
        print("[Overlay Manager] Key %s already exists" % key)
        return

    for overlay_key in _overlays:
        _overlays[overlay_key].visible = overlay_key == key
    
    var instance = packed.instantiate()
    add_overlay_node(key, instance)
    return instance

func add_overlay_node(key: String, node: Node) -> void:
    if key in _overlays:
        print("[Overlay Manager] Key %s already exists" % key)
        return

    for overlay_key in _overlays:
        _overlays[overlay_key].visible = overlay_key == key

    _overlays[key] = node

    if node.get_parent():
        node.reparent(self)
    else:
        add_child(node)

    if node.has_signal("closed"):
        node.closed.connect(func(): hide_overlay(key))

func hide_overlay(key: String) -> void:
    if key not in _overlays:
        push_error("[Overlay Manager] Key %s not found" % key)
        return

    var overlay = _overlays[key]
    overlay.hide()

func free_overlay(key: String) -> void:
    if key not in _overlays:
        push_error("[Overlay Manager] Key %s not found" % key)
        return

    var overlay = _overlays[key]

    if overlay.is_queued_for_deletion():
        push_warning("[Overlay Manager] Overlay %s is already queued for deletion" % key)
        return

    overlay.queue_free()

func show_overlay(key: String) -> void:
    if key not in _overlays:
        push_error("[Overlay Manager] Key %s not found" % key)
        return

    var overlay = _overlays[key]
    overlay.show()