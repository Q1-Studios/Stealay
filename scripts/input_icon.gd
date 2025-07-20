@tool
extends Sprite2D

var current: Globals.InputSrc = Globals.InputSrc.KEYBOARD

@export_group("Icons")
@export var keyboard_icon: Texture2D
@export var playstation_icon: Texture2D
@export var xbox_icon: Texture2D
@export var nintendo_icon: Texture2D
@export var generic_icon: Texture2D

@export_group("Preview")
@export var preview: Globals.InputSrc = Globals.InputSrc.KEYBOARD

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		change_icon_type(preview)

func _ready() -> void:
	if not Engine.is_editor_hint():
		current = Globals.last_input_src
		change_icon_type(current)

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		var joy_name: String = Input.get_joy_name(event.device)
		
		if joy_name.contains("PlayStation") or joy_name.contains("DualShock"):
			current = Globals.InputSrc.PLAYSTATION
		elif joy_name.contains("Xbox"):
			current = Globals.InputSrc.XBOX
		elif joy_name.contains("Switch"):
			current = Globals.InputSrc.NINTENDO
		else:
			current = Globals.InputSrc.GENERIC
		
	elif event is InputEventKey:
		current = Globals.InputSrc.KEYBOARD
	
	if not Engine.is_editor_hint():
		Globals.last_input_src = current
		change_icon_type(current)


func change_icon_type(type: Globals.InputSrc) -> void:
	match type:
		Globals.InputSrc.KEYBOARD:
			texture = keyboard_icon
		Globals.InputSrc.PLAYSTATION:
			texture = playstation_icon
		Globals.InputSrc.XBOX:
			texture = xbox_icon
		Globals.InputSrc.NINTENDO:
			texture = nintendo_icon
		Globals.InputSrc.GENERIC:
			texture = generic_icon
