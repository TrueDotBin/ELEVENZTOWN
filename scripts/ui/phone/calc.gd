extends Control

# please dont blame me for the bad code

var _expr: Expression
var _input: String = ""

@export var container: Container
@export var display: Label

func _add_to_input(btn_text: String):
	match btn_text:
		"C":
			_input = ""
			
		"⌫":
			_input = _input.left(-1)

		_:
			_input += btn_text

	display.text = _input

func _on_btn_press(btn_text: String):
	if not btn_text == "=":
		_add_to_input(btn_text)
	else:
		var error = _expr.parse(_input)

		if not error == OK:
			var error_text = _expr.get_error_text()
			display.text = error_text

			push_error("[Calculator] %s" % error_text)
			return

		var result = _expr.execute()

		if not _expr.has_execute_failed():
			_input = str(result)
			display.text = _input

func _connect_all_buttons_in_container(contain: Container):
	for child in contain.get_children():
		if child is Button:
			child.pressed.connect(_on_btn_press.bind(child.text))

		if child is Container:
			_connect_all_buttons_in_container(child)

func _ready() -> void:
	_expr = Expression.new()
	_connect_all_buttons_in_container(container)
