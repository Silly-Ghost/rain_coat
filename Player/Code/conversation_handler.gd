extends Node2D

@onready var talk: Node2D = $Talk
@onready var questions: Node2D = $Questions

var questions_key: float = 0
var curr_convo:int = 0

var convo = {
}

func _ready() -> void:
	pass
	#talk.display_convo(greeting)

func play_convo(temp_convo, sound):
	$Talk/Type.stream = sound
	convo = temp_convo
	curr_convo = 0

	if check_if_event_is_true(convo[curr_convo]):
		return

	talk.visible = true
	talk.display_convo(convo)

func continue_convo():
	if curr_convo >= convo.convo_size:
		get_parent().get_parent().end_event()
		return
	if check_if_event_is_true(convo[curr_convo]):
		return

	talk.visible = true
	talk.display_convo(convo, curr_convo)

func display_questions(questions_num:int):
	if not questions.visible == true:
		questions.add_questions(convo[questions_num + 1])
		questions.show()
		questions_key = questions_num + 1

func process_response(response_num):
	questions_key += float(response_num) / 10.0
	talk.question_response(questions_key)

func check_if_event_is_true(message):
	if message.substr(0, 1) == "#":
		var split_message = message.split("#")
		get_parent().get_parent().move_char(int(split_message[1]), Vector2(int(split_message[2]), int(split_message[3])), int(split_message[4]))
		return true
	return false
