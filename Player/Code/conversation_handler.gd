extends Node2D

@onready var talk: Node2D = $Talk
@onready var questions: Node2D = $Questions

var questions_key: float = 0

var greeting = {

	"convo_size" : 19,

	0 : "Hmm... did I hear something.",
	1 : "Hello??? Oh, another one... I see. I guess you’ve died.",
	2 : "This is the Waiting Place.",
	3 : "It’s where people come after they... well pass on",
	4 : "And for some reason, after some time... they disappear.",

	5 : "cutscene event",

	6 : "I should introduce myself. My name is Primo",
	7 : "^!And you? Who are you?",
	8 : ["...", "I don’t know… I can’t remember.", "Your worst nightmare.", "Just a friend."],
	
	8.1 : "Silent, huh? That’s fine. Words are overrated anyway.",
	8.2 : "Ah, memory loss. That happens sometimes when people arrive. Don’t worry, you’ll figure it out.",
	8.3 : "Well, aren’t you dramatic? Let’s hope that’s not true.",
	8.4 : "A friend, you say? Good... We could all use a few more of those around here.",

	9: "Well, I guess I'll call you raincoat for now.",
	10: "Most people stay for a day or so.",
	11: "I’m sure you'll pass on soon enough.",
	12: "Unless you're not human... I’m just kidding that's impossible.",
	13: "Wait... know that I look closer...",
	14: "You're not human... are you?",
	15: "Ignore that... I just woke up this morning... night?",
	16: "I don’t even know anymore.",
	17: "Come on. I’ll show you around.",
	18: "There’s not much, but you’ll want to meet the others.",
	19: "Maybe they can help."
}

func _ready() -> void:
	talk.display_convo(greeting)

func display_questions(questions_num:int):
	if not questions.visible == true:
		questions.add_questions(greeting[questions_num + 1])
		questions.show()
		questions_key = questions_num + 1

func process_response(response_num):
	questions_key += float(response_num) / 10.0
	talk.question_response(questions_key)
