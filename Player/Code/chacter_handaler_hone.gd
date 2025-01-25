extends Node2D

var scene_script = {}

@onready var camera_2d_path = "../Camera2D"

@onready var player: CharacterBody2D = $Player
@onready var player_remote_transform_2d: RemoteTransform2D = $Player/RemoteTransform2D
@onready var cutscene_remote_transform_2d: RemoteTransform2D = $Primo/RemoteTransform2D
var curr_camera = player_remote_transform_2d
var is_palying_event:bool = false


var npcs = [
	"Primo",
	"Wryan",
	"world dialogue",
	"CutScene Camera",
	"Player"
]

func _ready():
	$"../Camera2D".position = player.position
	$Player.last_input_vector = Vector2(0,-1)

func set_event(temp_script):
	scene_script = temp_script


func move_char_to_location(char_num:int, location:Vector2, speed:int):
	get_node(npcs[char_num]).move_to_location(location, speed)


func _on_player_triger_event_event(eventName:String,npc: int) -> void:

	if not is_palying_event:
		is_palying_event = true

		scene_script = get_node(npcs[npc]).get_dialogue(eventName)

		player.play_convo(scene_script, get_node(npcs[npc]).sound)


func _on_wryan_on_char_reached_loaction() -> void:
	player.continue_convo()


func _on_player_event_anim(char_num: int, anim: String) -> void:
	get_node(npcs[char_num]).play_aniamtion(anim)


func _on_player_event_finished() -> void:
	is_palying_event = false
	cutscene_remote_transform_2d.remote_path = ""
	player_remote_transform_2d.remote_path = "../../../Camera2D"


func _on_player_pass_camera(temp_char: Variant) -> void:
	curr_camera.remote_path = ""
	curr_camera = get_node(npcs[temp_char]+"/RemoteTransform2D")
	curr_camera.remote_path = "../../../Camera2D"
