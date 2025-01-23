extends Node2D


# #1#360#664#37 #npc_num#move_to_x_cord#move_to_y_cord#speed /// move event
# % /// auto play next message glitch
# ^! ///Question
# 5 : ["hi", "no"] /// player responses format
# for each responses add a responses from npc like 5.1 5.2 following the arrays num
# *1:-5:reset of message... * is relationship mod 1:-5: /// npc_num:mod_amount:rest_of_message

@onready var player: CharacterBody2D = $Player

var scene_script = {
	"convo_size" : 10,

	0 : "Once, long ago, this was a place of passage.",
	1 : "A bridge between what was and what might be. But time...",
	2 : "Time has a way of making even bridges crumble.",
	3 : "Now, it is a waiting place, where lost souls linger.",

	4 : "You are not like them, though.",
	5 : "No, you are something else.",
	6 : "Something the waiting place itself has created.",
	7 : "A thing of purpose.",

	8 : "Remember this, what is broken must be fixed.",
	9 : "What lingers too long must be removed.",
	10 : "The clock does not turn for those who wait too long.",

}

func _ready() -> void:
	player.last_input_vector = Vector2(0, 1)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "player_load":
		$AnimationPlayer.play("idle")
		player.play_convo(scene_script, load("res://Sounds/Type 2.ogg"))
