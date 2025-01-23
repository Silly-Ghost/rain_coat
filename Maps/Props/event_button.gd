extends TextureButton

@export var eventName:Array = ["Bridge 0", "Bridge 0.1", "Bridge 0.2"]
@export var max_stages:int = 3
@export var npc:int = 2

var stage:int = 0

signal event(eventNum:String, npc:int)

func _ready() -> void:
	if not Data.save_file["events"].has(eventName[0]):
		Data.save_file["events"][eventName[0]] = false
	elif Data.save_file["events"][eventName[0]] == true:
		queue_free()


func _on_pressed() -> void:
	if Data.save_file["events"][eventName[0]] != true:
		emit_signal("event", eventName[stage], npc)
		stage += 1
		if stage >= max_stages:
			Data.save_file["events"][eventName[0]] = true
			queue_free()
	else:
		queue_free()
