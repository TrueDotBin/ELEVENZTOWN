@tool

class_name UIPalette
extends Resource

@export_category("Colors")
@export var primary_background: Color
@export var secondary_background: Color
@export var foreground: Color
@export var accent: Color
@export var danger: Color
@export var warning: Color
@export var success: Color

@export_category("Themes")
@export var target_theme: Theme

@export_tool_button("Rebuild Theme") var rebuild_action = _rebuild_theme

func _rebuild_theme() -> void:
    if not target_theme:
        push_warning("Please attach a theme in the inspector!")
        return

    _theme_panel()
    _theme_buttons()
    
    _set_button_colors("SuccessButton", success)
    _set_button_colors("DangerButton", danger)
    _set_button_colors("WarningButton", warning)

    target_theme.set_type_variation("SuccessButton", "Button")
    target_theme.set_type_variation("DangerButton", "Button")
    target_theme.set_type_variation("WarningButton", "Button")

    _set_text_colors()

    ResourceSaver.save(target_theme, target_theme.resource_path)

func _button_box() -> StyleBoxFlat:
    var stylebox = StyleBoxFlat.new()
    stylebox.set_border_width_all(2)
    stylebox.set_corner_radius_all(16)
    stylebox.set_content_margin_all(10)

    stylebox.border_color = accent
    stylebox.bg_color = secondary_background

    stylebox.shadow_offset = Vector2(0, 2)
    stylebox.shadow_size = 1
    stylebox.shadow_color = primary_background

    return stylebox

func _hover_button(base: StyleBoxFlat) -> StyleBoxFlat:
    var hover_button = base.duplicate()
    hover_button.set_border_width_all(3)
    
    hover_button.bg_color = base.bg_color.lightened(0.1)

    return hover_button

func _pressed_button(base: StyleBoxFlat) -> StyleBoxFlat:
    var pressed_button = base.duplicate()
    pressed_button.set_border_width_all(1)

    pressed_button.shadow_offset = Vector2(0, 1)

    return pressed_button

func _focus_button(base: StyleBoxFlat) -> StyleBoxFlat:
    var focus_button = base.duplicate()
    focus_button.bg_color = Color.TRANSPARENT
    focus_button.border_color = base.bg_color.lightened(0.25)
    focus_button.border_width_left = 2
    focus_button.border_width_right = 2
    focus_button.border_width_top = 2
    focus_button.border_width_bottom = 2

    return focus_button

func _button_text_colors() -> void:
    target_theme.set_color("font_color", "Button", foreground)
    target_theme.set_color("font_hover_color", "Button", foreground)
    target_theme.set_color("font_pressed_color", "Button", foreground)
    target_theme.set_color("font_focus_color", "Button", foreground)
    target_theme.set_color("font_disabled_color", "Button", foreground.darkened(0.5))

func _set_text_colors() -> void:
    _button_text_colors()
    target_theme.set_color("font_color", "Label", foreground)

func _set_button_colors(type_name: StringName, base_color: Color):
    var normal_button = _button_box()
    normal_button.bg_color = base_color
    normal_button.border_color = base_color.lightened(0.25)
    normal_button.shadow_color = base_color.darkened(0.25)

    var hover_button = _hover_button(normal_button)
    var pressed_button = _pressed_button(normal_button)
    var focus_button = _focus_button(normal_button)

    target_theme.set_stylebox("normal", type_name, normal_button)

    target_theme.set_stylebox("hover", type_name, hover_button)
    target_theme.set_stylebox("hover_pressed", type_name, hover_button)

    target_theme.set_stylebox("pressed", type_name, pressed_button)
    target_theme.set_stylebox("focus", type_name, focus_button)

func _theme_buttons() -> void:
    var normal_button = _button_box()
    var hover_button = _hover_button(normal_button)
    var pressed_button = _pressed_button(normal_button)
    var focus_button = _focus_button(normal_button)

    target_theme.set_stylebox("normal", "Button", normal_button)

    target_theme.set_stylebox("hover", "Button", hover_button)
    target_theme.set_stylebox("hover_pressed", "Button", hover_button) # CheckBox and CheckButton look weird without this

    target_theme.set_stylebox("pressed", "Button", pressed_button)
    target_theme.set_stylebox("focus", "Button", focus_button)

func _theme_panel() -> void:
    var panel_box = StyleBoxFlat.new()

    panel_box.set_border_width_all(2)
    panel_box.set_corner_radius_all(16)
    panel_box.set_content_margin_all(10)

    panel_box.bg_color = Color(primary_background, 0.5)
    panel_box.border_color = accent

    target_theme.set_stylebox("panel", "Panel", panel_box)