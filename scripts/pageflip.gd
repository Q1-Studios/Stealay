extends Sprite2D

@export var current_view: Viewport
@export var mesh_material_to_flip: StandardMaterial3D
@export var animation_player: AnimationPlayer


func _ready() -> void:
	show()

func _on_page_flip() -> void:
	var current_image = current_view.get_texture().get_image()
	mesh_material_to_flip.albedo_texture = ImageTexture.create_from_image(current_image)

	animation_player.play("deformflip")
