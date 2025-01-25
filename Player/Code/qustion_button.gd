extends TextureButton

@onready var question_num_label: Label = $"Question Num"
@onready var question_label: Label = $Question

var is_hovering:bool = false
var question_num

signal question_response(num)


func set_button(temp_question_num, question) -> void:
	question_num = temp_question_num
	question_num_label.text = str(question_num, ":")
	question_label.text = question

func _process(_delta: float) -> void:
	if is_hovered() != is_hovering:
		is_hovering = not is_hovering
		scale = Vector2(1.05, 1.05) if is_hovering else Vector2(1, 1)

func _on_pressed() -> void:
	question_response.emit(question_num)
