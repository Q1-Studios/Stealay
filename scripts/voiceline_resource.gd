extends Resource

class_name Voiceline

@export_multiline var text: String = ""
@export var audio_stream: AudioStream

@export_group("Touch Alternative")
@export var touch_alternative: bool = false
@export_multiline var text_touch: String = ""
@export var audio_stream_touch: AudioStream
