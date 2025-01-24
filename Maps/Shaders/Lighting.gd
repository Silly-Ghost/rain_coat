extends ColorRect
class_name lighting

var screanScale:float = 4.0

@export var additiveScale:float = 1

func _ready() -> void:
	show()

func _process(_delta: float) -> void:
	var lights = get_lights()
	var lightPos = get_light_pos(lights)
	var lightRadiusAr = get_light_rad(lights)
	var lightColorAr = get_light_color(lights)
	var brightnesAr = get_light_brightnes(lights)

	screanScale = calculate_screen_scale()

	for i in lightPos.size():
		lightPos[i] = Vector2(lightPos[i].x * screanScale, lightPos[i].y * screanScale)

	screanScale = screanScale / additiveScale


	material.set_shader_parameter("numOfLight", lightPos.size())
	material.set_shader_parameter("lights", lightPos)
	material.set_shader_parameter("lightRadiusAr", lightRadiusAr)
	material.set_shader_parameter("lightColorAr", lightColorAr)
	material.set_shader_parameter("lightBrightnesAr", brightnesAr)

	material.set_shader_parameter("screenScale", screanScale * 10)


func calculate_screen_scale():
	var baseResolution = Vector2(1920, 1080)
	var currentResolution = DisplayServer.window_get_size()
	var screenScale = (currentResolution.y * 4) / baseResolution.y

	return screenScale

func get_light_rad(lights):
	var lightRad:Array = []

	for light in lights:
		lightRad.append(light.radius)

	return lightRad

func get_light_color(lights):
	var lightCol:Array = []

	for light in lights:
		lightCol.append(light.color)

	return lightCol

func get_light_brightnes(lights):
	var brightnes:Array = []

	for light in lights:
		brightnes.append(light.brightnes)

	return brightnes

func get_light_pos(lights):
	return lights.map(
		func(Light: Node2D):
			return Light.get_global_transform_with_canvas().origin)

func get_lights():
	var lights =  get_tree().get_nodes_in_group("Lights")
	var deletedKey:int = 0

	for i in lights.size():
		if lights[i - deletedKey].isOn == false:
			lights.remove_at(i - deletedKey)
			deletedKey += 1
	return lights
