extends Control

@export_category("App Metadata")
@export var app_name: String = "App"
@export var app_icon: Texture2D
@export var app_screen: String

@export_category("Other")
@export var home_screen: HomeScreen

@onready var app_name_label: Label = $AppNameLabel
@onready var app_icon_tr: TextureRect = $AppIcon

func _ready() -> void:
	app_name_label.text = app_name
	app_icon_tr.texture = app_icon

func _on_click_handler_pressed() -> void:
	home_screen.app_requested.emit(app_screen)
