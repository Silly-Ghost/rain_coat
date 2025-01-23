extends Node2D


signal change_scene(scene, player_cords, color_num)


func on_change_scene(scene:String, player_cords:Vector2 = Vector2.ZERO, color_num:int = 0):
	emit_signal("change_scene", scene, player_cords, color_num)

func clean_up():
	queue_free()

func play_song(song):
	get_parent().play_song(song)
