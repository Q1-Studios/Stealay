extends Node2D

@export var force_show: bool = false

func _ready() -> void:
	visible = Globals.is_mobile or force_show
