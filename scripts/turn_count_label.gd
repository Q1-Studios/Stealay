extends Label

func _ready() -> void:
	text = "0"

func _process(_delta: float) -> void:
	text = str(Globals.current_move)
