extends TileMap

@onready var camera_2d: Camera2D = $"../Camera2D"
@onready var bottom_right: Marker2D = $BottomRight

func _ready() -> void:
	camera_2d.limit_bottom = bottom_right.position.y
	camera_2d.limit_left = 0
	camera_2d.limit_right = bottom_right.position.x
	camera_2d.limit_top = 0
