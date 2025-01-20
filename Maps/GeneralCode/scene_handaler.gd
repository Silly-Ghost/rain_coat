extends Node2D

@onready var curr_map: Node2D = $TestMap
@onready var fader: AnimationPlayer = $Fader
var is_fullscreen = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_released("fullscreen"):
		if is_fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			is_fullscreen = false
			return
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		is_fullscreen = true

func _ready() -> void:
	fader.get_child(0).show()
	curr_map.connect("change_scene", Callable(self, "on_change_scene"))

func on_change_scene(scene, player_cords):
	pass
