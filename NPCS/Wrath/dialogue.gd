extends Node

# #1#360#664#37 #npc_num#move_to_x_cord#move_to_y_cord#speed /// move event
# % /// auto play next message glitch
# ^! ///Question
# 5 : ["hi", "no"] /// player responses format
# for each responses add a responses from npc like 5.1 5.2 following the arrays num
# *1:-5:reset of message... * is relationship mod 1:-5: /// npc_num:mod_amount:rest_of_message


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


	"Bridge 1" : {
		"convo_size" : 14,

		0: "#1#360#664#75",
		1: "#1#394#664#75",

		2 : "Stop right there! Don’t even think about coming any closer.",
		3 : "Don’t you get it? I don’t want anyone around me!",
		4 : "%This place IS MIIIIINEEEEEE",
		5 : "%TO DESTROY.",
		6 : "Just leave.",

		7: "^!What do you even want?",
		8: ["Are you're scared?", "You're protecting something?", "Are you're angry?"],
		8.1: "*1:-5:Scared? Ha! I’m not scared of anything! You’ve got it all wrong pal.",
		8.2: "*1:5:Protecting something? As if there’s anything worth protecting here.",
		8.3: "*1:0:Angry? Yeah, I’m angry! Furious! And if you’re smart, you’ll stay away.",

		9: "%You’re wasting your time.",
		10: "No one gets it... and you won’t either. Just leave.",
		11: "#1#279#664#75",
		12: "#1#279#775#75",
		13: "#1#200#775#75",
		14: "#1#200#835#75",
	},
}
