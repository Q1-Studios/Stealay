@tool
extends Sprite2D

@export_group("Icons")
@export var keyboard_icon: Texture2D
@export var playstation_icon: Texture2D
@export var xbox_icon: Texture2D
@export var nintendo_icon: Texture2D
@export var generic_icon: Texture2D

@export_group("Preview")
@export var preview: InputSrcDetector.InputSrc = InputSrcDetector.InputSrc.KEYBOARD

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		change_icon_type(preview)

func _ready() -> void:
	if not Engine.is_editor_hint():
		change_icon_type(InputSrcDetector.current_src)
		InputSrcDetector.input_changed.connect(change_icon_type)

func change_icon_type(type: InputSrcDetector.InputSrc) -> void:
	match type:
		InputSrcDetector.InputSrc.KEYBOARD:
			texture = keyboard_icon
		InputSrcDetector.InputSrc.TOUCH:
			texture = keyboard_icon
		InputSrcDetector.InputSrc.PLAYSTATION:
			texture = playstation_icon
		InputSrcDetector.InputSrc.XBOX:
			texture = xbox_icon
		InputSrcDetector.InputSrc.NINTENDO:
			texture = nintendo_icon
		InputSrcDetector.InputSrc.GENERIC:
			texture = generic_icon
