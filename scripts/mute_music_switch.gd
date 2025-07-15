extends SmartButton

var musicBus = AudioServer.get_bus_index("Music")

func _ready() -> void:
	button_pressed = AudioServer.is_bus_mute(musicBus)

func _on_pressed() -> void:
	AudioServer.set_bus_mute(musicBus, not AudioServer.is_bus_mute(musicBus))
