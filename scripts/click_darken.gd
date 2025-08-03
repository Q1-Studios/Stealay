extends Sprite2D


@export var btn_src: Pressable

func _process(_delta: float) -> void:
	if btn_src.is_pressed():
		modulate.v = 0.5
	else:
		modulate.v = 1
