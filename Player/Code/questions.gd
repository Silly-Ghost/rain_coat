extends Node2D

const QUESTION_BUTTON = preload("res://Player/Conversation Handler/question_button.tscn")

@onready var conversation_handler: Node2D = $".."
@onready var container: VBoxContainer = $Container

var buttons:Array = []


func add_questions(questions:Array):
	var curr_questions_num:int = 0

	for question in questions:
		curr_questions_num += 1
		var temp_button = QUESTION_BUTTON.instantiate()
		container.add_child(temp_button)
		temp_button.set_button(curr_questions_num, question)
		buttons.append(temp_button)
		temp_button.connect("question_response", Callable(self, "_on_question_response"))

func _on_question_response(response:int):
	hide()
	for button in buttons:
		button.queue_free()

	buttons = []
	conversation_handler.process_response(response)
