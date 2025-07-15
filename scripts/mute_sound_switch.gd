extends SmartButton

var soundBus = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	button_pressed = AudioServer.is_bus_mute(soundBus)

func _on_pressed() -> void:
	AudioServer.set_bus_mute(soundBus, not AudioServer.is_bus_mute(soundBus))
