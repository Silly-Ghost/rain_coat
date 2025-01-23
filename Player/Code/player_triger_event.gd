extends Area2D

@export var eventNanme:String = ""
@export var npc:int = 1

signal event(eventNum:String, npc:int)

func _ready() -> void:
	if not Data.save_file["events"].has(eventNanme):
		Data.save_file["events"][eventNanme] = false
	elif Data.save_file["events"][eventNanme] == true:
		queue_free()

func _on_body_entered(_body: Node2D) -> void:
	if Data.save_file["events"][eventNanme] != true:
		emit_signal("event", eventNanme, npc)
		Data.save_file["events"]["Bridge 0"] = true
		Data.save_file["events"][eventNanme] = true
		queue_free()
