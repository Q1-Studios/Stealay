extends ColorRect

var fademe = false
var quit = false

@onready var web_info: Label = $WebInfo

func _ready() -> void:
	hide()
	modulate.a = 0

func _on_play_button_pressed() -> void:
	fademe = true

func _on_quit_button_pressed() -> void:
	fademe = true
	quit = true

func _process(delta: float) -> void:
	if fademe:
		show()
		modulate.a += 1 * delta

func _on_pre_quit_hook() -> void:
	if(Globals.is_web):
		web_info.show()
