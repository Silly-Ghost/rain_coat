extends TextureButton

@export var scene = ""
@export var player_cords = Vector2.ZERO
@export_range (0,1) var color_num:int = 0
@onready var marker_2d: Marker2D = $Marker2D

signal change_scene(scene, player_cords, color_num)



func _on_pressed() -> void:
	print(get_parent().get_player_distance_from_pos(marker_2d.global_position))
	if get_parent().get_player_distance_from_pos(marker_2d.global_position) < 12:
		disabled = true
		change_scene.emit(scene, player_cords, color_num)
