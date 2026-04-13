extends Button

@onready var area = $Area2D

var has_broken : bool = false

var random1 = 100

var ordinata = Vector2(-150, 700)

var dragging = false
var drag_offset = Vector2.ZERO
var start_pos 

var already_checked = false

func _ready() -> void:
	area.body_entered.connect(_on_body_entered)
	#button_down.connect(_on_button_down)
	#button_up.connect(_on_button_up)
	
func _on_button_down() -> void:
	if dragging:
		return
		
	# 👇 Обновляем стартовую позицию перед перетаскиванием
	start_pos = position
	
	drag_offset = global_position - get_global_mouse_position()
	dragging = true

func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

func visibl(item):
	item.visible = true

func _on_button_up() -> void:
	if not dragging:
		return
		
	dragging = false
	position = start_pos
	
func _on_body_entered(body):
	if body.name == "Viewport":
		call_deferred("_deferred_move")

func _deferred_move():
	dragging = false
	
	get_parent().remove_child(self)
	GlobalVar.panel.add_child(self)
	position = ordinata
	visibl(GlobalVar.processor)
	
	if is_in_group("purch_bat"):
		GlobalVar.battery.visible = true
	elif is_in_group("purch_proc"):
		GlobalVar.processor.visible = true
		GlobalVar.brok_proc.visible = false
	elif is_in_group("purch_speak"):
		GlobalVar.speaker.visible = true
	elif is_in_group("purch_cam"):
		GlobalVar.camera.visible = true
