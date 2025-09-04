extends Resource

class_name Voiceline

@export_multiline var text: String = ""
@export var audio_stream: AudioStream

@export_group("Touch Alternative")
@export var touch_alternative: bool = false
@export_multiline var text_touch: String = ""
@export var audio_stream_touch: AudioStream

func get_text() -> String:
	if Globals.is_mobile and touch_alternative:
		return text_touch
	else:
		return text

func get_stream() -> AudioStream:
	if Globals.is_mobile and touch_alternative:
		return audio_stream_touch
	else:
		return audio_stream
