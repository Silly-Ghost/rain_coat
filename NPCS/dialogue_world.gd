extends Node

# #1#360#664#37 #npc_num#move_to_x_cord#move_to_y_cord#speed /// move event
# % /// auto play next message glitch
# ^! ///Question
# 5 : ["hi", "no"] /// player responses format
# for each responses add a responses from npc like 5.1 5.2 following the arrays num
# *1:-5:reset of message... * is relationship mod 1:-5: /// npc_num:mod_amount:rest_of_message
var sound = preload("res://Sounds/Type.ogg")

func get_dialogue(key) -> Dictionary:
	return dialogue[key]

var dialogue = {
	"Bridge 0" : {
		"convo_size" : 0,
		0 : "It's a broken bridge...",
	},
	"Bridge 0.1" : {
		"convo_size" : 0,
		0 : "Im still looking at it...",
	},
	"Bridge 0.2" : {
		"convo_size" : 0,
		0 : "Mabey I should walk up to it",
	},
}
