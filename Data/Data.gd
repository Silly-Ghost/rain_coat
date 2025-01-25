extends Node

var mice:Array = [preload("res://HardWare/Mouse.png"), preload("res://HardWare/Mouse Glass.png")]

var max_hp = 25
var hp = 25

var is_loaded = false
var events = [0,0,0,0]
var hearts = [0,0,0,0,0,0,0]

var save_file = {
	"is_loaded" : false,
	"events" : {},
	"heart_level" : [0,0,0,0,0,0,0],
	"player_pos" : Vector2.ZERO
}


#-> initialize <-#

func _ready() -> void:
	set_mice_icons()

func set_mice_icons():
	Input.set_custom_mouse_cursor(mice[1], Input.CURSOR_POINTING_HAND, Vector2(0,0))
	Input.set_custom_mouse_cursor(mice[0] ,Input.CURSOR_ARROW, Vector2(0,0))

#-> SAVE HANDALER <-#

var data = {}
var saveFile = 0
var SAVE_FOLDER = "user://savefiles/save_"
var WORLD_FOLDER = "Worlds"
const DATA_EXTENSION:String = ".dat"
const SAVE_FILE_PATH:String = "user://savefiles/Save_Data.dat"

func get_save_file_path(type: String) -> String:
	var dir = DirAccess.open("user://")
	match type:
		"data":
			dir.make_dir_recursive("savefiles")
			return SAVE_FILE_PATH
	return ""

func save_game():
	var file = FileAccess.open(get_save_file_path("data"), FileAccess.WRITE)
	data = {"save_file" = save_file}
	file.store_var(data)
	file = null

func load_game():
	if not FileAccess.file_exists(get_save_file_path("data")):
		data = {
			"save_file" = {
			"events" : {},
			"heart_level" : [0,0,0,0,0,0,0],
			"player_pos" : Vector2.ZERO
			}
		}
		save_game()
	
	var file = FileAccess.open(get_save_file_path("data"), FileAccess.READ)
	data = file.get_var()
	save_file = data.save_file
	file = null
