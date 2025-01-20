extends Node2D

const TILE = preload("res://Attacks/Tile.tscn")
var postions = []

func _ready() -> void:
	for i in randi_range(40,64):
		var x = randi_range(0,7)
		var y = randi_range(0,7)
		if not postions.has(Vector2(x,y)):
			postions.append(Vector2(x,y))
			var tile_load = TILE.instantiate()
			add_child(tile_load)
			tile_load.position = Vector2(x*16,y*16)
			tile_load.set_timer(randf_range(0, 4))
