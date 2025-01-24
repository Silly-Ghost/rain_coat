extends Node

# #1#360#664#37 #npc_num#move_to_x_cord#move_to_y_cord#speed /// move event
# % /// auto play next message glitch
# ^! ///Question
# 5 : ["hi", "no"] /// player responses format
# for each responses add a responses from npc like 5.1 5.2 following the arrays num
# *1:-5:reset of message... * is relationship mod 1:-5: /// npc_num:mod_amount:rest_of_message


var dialogue = {
	"greeting" : {
		"convo_size" : 31,

		0 : "Hmm... did I hear something.",
		1 : "!0!qustion",
		2 : "Oh, another one... I see. I guess you’ve died.",
		
		3: "#0#614#630#25",
		
		4 : "This is the Waiting Place.",
		5 : "It’s where people come after they... well pass on",
		6 : "And for some reason, after some time... they disappear.",
		
		7 : "!4!stand_up",

		8: "#0#596#630#25",
		9: "#0#596#658#25",
		10: "#0#605#658#25",

		11 : "I should introduce myself. My name is Primo",
		12 : "^!And you? Who are you?",
		13 : ["...", "I don’t know… I can’t remember.", "Your worst nightmare.", "Just a friend."],
		
		13.1 : "Silent, huh? That’s fine. Words are overrated anyway.",
		13.2 : "Ah, memory loss. That happens sometimes when people arrive. Don’t worry, you’ll figure it out.",
		13.3 : "Well, aren’t you dramatic? Let’s hope that’s not true.",
		13.4 : "A friend, you say? Good... We could all use a few more of those around here.",

		14: "Well, I guess I'll call you raincoat for now.",
		15: "Most people stay for a day or so.",
		16: "I’m sure you'll pass on soon enough.",
		17: "Unless you're not human...  hahaha. I’m just kidding.",
		18: "Wait... know that I look closer...",
		19: "You're not human... are you?",
		20: "Ignore that... I just woke up this morning... night?",
		21: "I don’t even know anymore.",
		22: "Come on. You should go meet everyone.",
		23: "There’s not much, but you’ll want to meet them.",
		24: "Maybe they can help... I'll be in the house",

		25: "<>4",
		26: "#0#605#674#100",
		27: "#0#694#674#100",
		28: "#0#694#660#100",
		29: "#0#888#660#100",
		30: "!0!gone", # set_postion
		31: "!0!gone" # set_postion
	},
}
