extends Camera3D

var Sensivity : float = 4.5
var rotation_x = 0.0
var rotation_y = 0.0

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		rotation_y -= event.relative.x / 1000 * Sensivity
		rotation_x -= event.relative.y / 1000 * Sensivity
		rotation_x = clamp(rotation_x, deg_to_rad(-45), deg_to_rad(45))
		
		rotation.y = rotation_y
		rotation.x = rotation_x
