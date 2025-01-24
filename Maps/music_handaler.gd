extends AudioStreamPlayer

var curr_song:String = ""
var next_song:String = ""
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_song(song):
	if curr_song == "":
		curr_song = song
		stream = load("res://Sounds/music/" + song + ".ogg")
		play()
	else:
		animation_player.play("Fade_Out_Music")
		next_song = song


func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	stop()
	volume_db = 0
	if next_song != "":
		stream = load("res://Sounds/music/" + next_song + ".ogg")
		play()
