extends Node2D

@onready var curr_scene: Node2D = $splash
@onready var fader: AnimationPlayer = $CanvasLayer/Fader

var is_fullscreen = false
var fade_color:int = 0
var scene_path = "res://Maps/maps/"
var next_scene = null

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("fullscreen"):
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			is_fullscreen = false
			return
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		is_fullscreen = true

func _ready() -> void:
	Data.load_game()
	fader.get_child(0).show()
	curr_scene.connect("change_scene", Callable(self, "on_change_scene"))

func on_change_scene(scene, player_cords, temp_fade_color):
	fade_color = temp_fade_color
	match fade_color:
		0:
			fader.play("Fade_Out")
		1:
			fader.play("Fade_Out_White")

	next_scene = load(scene_path + scene + ".tscn").instantiate()


func _on_fader_animation_finished(anim_name: StringName) -> void:
	if anim_name.substr(0,8) == "Fade_Out":
		add_child(next_scene)
		next_scene.connect("change_scene", Callable(self, "on_change_scene"))
		curr_scene.clean_up()
		curr_scene = next_scene
		next_scene = null
		match anim_name:
			"Fade_Out":
				fader.play("Fade_In")
			"Fade_Out_White":
				fader.play("Fade_In_White")


func play_song(song):
	$Music_handaler.play_song(song)
