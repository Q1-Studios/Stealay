extends Control

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if Globals.allow_speedup:
		show()
	else:
		hide()
