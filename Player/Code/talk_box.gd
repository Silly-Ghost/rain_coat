extends Node2D

@onready var update_timer: Timer = $update_timer
@onready var label: Label = $Label
@onready var type: AudioStreamPlayer = $Type
@onready var next_arrow: Sprite2D = $"Next Arrow"
@onready var conversation_handler: Node2D = $".."

const UPDATE_SPEED_UPER_RANGE:float = 0.075
const UPDATE_SPEED_LOWER_RANGE:float = 0.05
const UPDATE_SPEED_EXCLUDED_CHARS:float = 0.4
const EXCLUDED_CHARS:Array = [",", ".", "!", "?"]

var curr_message:String = ""
var display_message:String = ""

var is_waiting:bool = true
var is_question:bool = false
var is_auto:bool = false
var waitng_on_response:bool = false
var convo_data:Dictionary = {}
var curr_convo:int = 0
var convo_size:int = 0
var curr_char:int = 0
var message_lenght:int = 0

#-> conversation handaler <-#

func display_convo(temp_convo:Dictionary, temp_curr_convo:int = 0) -> void:
	convo_data = temp_convo
	curr_convo = temp_curr_convo
	convo_size = convo_data.convo_size
	type_message(convo_data[curr_convo])

func update_convo() -> void:
	if not waitng_on_response:
		if is_question:
			conversation_handler.display_questions(curr_convo)
			waitng_on_response = true
			return

		if convo_size > curr_convo:
			curr_convo += 1
			type_message(convo_data[curr_convo])
			return
		else:
			get_parent().get_parent().get_parent().end_event()
			is_waiting = true
			visible = false

func check_if_question(message) -> bool:
	if message.substr(0, 2) == "^!":
		curr_char += 2
		return true
	return false

func check_if_auto(message):
	if message.substr(0, 1) == "%":
		curr_char += 1
		return true
	return false

func question_response(response_key):
	is_question = false
	waitng_on_response = false
	curr_convo += 1
	type_message(convo_data[response_key])

#-> message handaler <-#

func type_message(update_message):
	display_message = ""
	next_arrow.visible = false
	curr_message = update_message
	curr_char = 0
	message_lenght = curr_message.length()

	is_question = check_if_question(curr_message)
	is_auto = check_if_auto(curr_message)
	if get_parent().check_if_camera_pass(curr_message):
		update_convo()

	get_parent().curr_convo = curr_convo
	if get_parent().check_if_event_is_true(curr_message) or get_parent().check_if_amnim(curr_message):
		is_waiting = true
		message_lenght = 0
		curr_message = ""
		visible = false
		return

	_on_update_timer_timeout()

func _on_update_timer_timeout() -> void:
	if message_lenght > curr_char:
		display_message += curr_message[curr_char]
		curr_char += 1
		label.text = display_message
		type.play()

		if message_lenght > curr_char:
			update_timer.wait_time = UPDATE_SPEED_EXCLUDED_CHARS if curr_message[curr_char] in EXCLUDED_CHARS else randf_range(UPDATE_SPEED_LOWER_RANGE, UPDATE_SPEED_UPER_RANGE)
			update_timer.start()
		else:
			if is_auto:
				update_convo()
				return
			update_arrow()
	else:
		update_arrow()

func update_arrow() -> void:
	next_arrow.visible = true if next_arrow.visible == false else false
	update_timer.wait_time = 0.5
	update_timer.start()

#-> input handaler <-#

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("click") and not is_waiting:
		if message_lenght <= curr_char:
			update_convo()
			return
		if message_lenght > curr_char and not is_auto:
			display_message = curr_message if not is_question else curr_message.substr(2, message_lenght)
			curr_char = message_lenght
			label.text = display_message
			update_timer.stop()
			_on_update_timer_timeout()
