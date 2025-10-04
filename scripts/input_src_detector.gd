extends Node

signal input_changed(type: InputSrc)

enum InputSrc {KEYBOARD, TOUCH, PLAYSTATION, XBOX, NINTENDO, GENERIC}

var current_src: InputSrc
var previous_src: InputSrc

func _ready() -> void:
	# Default setup for platforms before anything is pressed
	if Globals.is_mobile:
		current_src = InputSrc.TOUCH
	else:
		current_src = InputSrc.KEYBOARD
	previous_src = current_src

func _input(event: InputEvent) -> void:
	if (event is InputEventJoypadButton or
	(event is InputEventJoypadMotion and abs(event.axis_value) >= 0.5)):
		var joy_name: String = Input.get_joy_name(event.device).to_lower()
		
		if joy_name.contains("playstation") or joy_name.contains("dualshock") or joy_name.contains("dualsense"):
			current_src = InputSrc.PLAYSTATION
		elif joy_name.contains("xbox"):
			current_src = InputSrc.XBOX
		elif joy_name.contains("switch"):
			current_src = InputSrc.NINTENDO
		else:
			current_src = InputSrc.GENERIC
	
	elif event is InputEventScreenTouch:
		current_src = InputSrc.TOUCH
	
	elif event is InputEventKey:
		current_src = InputSrc.KEYBOARD
	
	if current_src != previous_src:
		input_changed.emit(current_src)
		previous_src = current_src
