extends Node2D

var scene_script = {}

@onready var player: CharacterBody2D = $Player


var npcs = [
	"Primo",
	"Wryan",
	"world dialogue"
]

func set_event(temp_script):
	scene_script = temp_script


func move_char_to_location(char_num:int, location:Vector2, speed:int):
	get_node(npcs[char_num]).move_to_location(location, speed)


func _on_player_triger_event_event(eventName:String,npc: int) -> void:
	scene_script = get_node(npcs[npc]).get_dialogue(eventName)

	player.play_convo(scene_script, get_node(npcs[npc]).sound)


func _on_wryan_on_char_reached_loaction() -> void:
	player.continue_convo()
