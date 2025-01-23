extends TextureButton

@onready var sprite: Sprite2D = $Sprite2D
@onready var hover_sound: AudioStreamPlayer = $hover_sound
@onready var pressed_sound: AudioStreamPlayer = $pressed_sound


@export var Type: String
@export var scaleHoverSize = 1.05

var is_presed = false
var isSelected = false

signal buttonPressed(Type)


func _process(_delta):

	if is_hovered():
		if not isSelected:
			isSelected = true
			sprite.scale = Vector2(scaleHoverSize, scaleHoverSize)
			hover_sound.play()

	elif isSelected:
		isSelected = false
		sprite.scale = Vector2(1, 1)


	if isSelected:
		if Input.is_action_just_pressed("click"):
			sprite.scale = Vector2(1, 1)
		elif Input.is_action_just_released("click") and not is_presed:
			is_presed = true
			sprite.scale = Vector2(scaleHoverSize, scaleHoverSize)
			pressed_sound.play()
			buttonPressed.emit(Type)
