extends CanvasLayer

@onready var ambi: AudioStreamPlayer = $Ambi
@onready var abmi_fade: AnimationPlayer = $Ambi/abmi_fade


func _ready() -> void:
	abmi_fade.play("fade_in")
	get_parent().play_song("waiting sky")
