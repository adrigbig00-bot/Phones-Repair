extends Button

@onready var area = $Area2D

var has_broken : bool = false

@onready var phone = $"../.."

var is_broken1 = true

var time : int = 120

var ordinata = Vector2(-150, 700)

var dragging = false
var drag_offset = Vector2.ZERO
var start_pos 

var already_checked = false

var random1 = randi_range(1, 100)

func is_panel_color(panel : Panel, target_color : Color) -> bool:
	 # Получаем текущий стиль панели
	var style = panel.get_theme_stylebox("panel")
	if style is StyleBoxFlat:
		return style.bg_color == target_color
	return false

func okraska(item):
	var style = StyleBoxFlat.new()
	style.bg_color = Color.GREEN
	item.add_theme_stylebox_override("panel", style)

func _ready() -> void:
	if area != null:
		area.body_entered.connect(_on_body_entered)
		
func select_self():
	if self.is_in_group("batteryui"):
		return GlobalVar.panbat
	elif self.is_in_group("processorui"):
		return GlobalVar.panproc
	elif self.is_in_group("speakerui"):
		return GlobalVar.panspeak
	elif self.is_in_group("cameraui"):
		return GlobalVar.pancam

func select_ui():
	if self.is_in_group("batteryui"):
		return GlobalVar.battery_ui
	elif self.is_in_group("processorui"):
		return GlobalVar.processor_ui
	elif self.is_in_group("speakerui"):
		return GlobalVar.speaker_ui
	elif self.is_in_group("cameraui"):
		return GlobalVar.camera_ui

func select_blok():
	if self.is_in_group("batteryui"):
		return GlobalVar.brok_bat
	elif self.is_in_group("processorui"):
		return GlobalVar.brok_proc
	elif self.is_in_group("speakerui"):
		return GlobalVar.brok_speak
	elif self.is_in_group("cameraui"):
		return GlobalVar.brok_cam
	return null

func _on_button_down() -> void:
	
	if dragging:
		return
		
	# 👇 Обновляем стартовую позицию перед перетаскиванием
	start_pos = position
	
	drag_offset = global_position - get_global_mouse_position()
	dragging = true

func _process(_delta):
	
	if GlobalVar.disable_all_drag:
		dragging = false
		return
	
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

func _on_button_up() -> void:
	if not dragging:
		return
		
	dragging = false
	position = start_pos

func start_remont_detail():
	var panel = select_self()
	if not panel:
		return 
	
	var current_style = panel.get_theme_stylebox("panel")
	if current_style is StyleBoxFlat and current_style.bg_color == Color.GREEN:
		return
		
	dragging = false
	position = start_pos
	GlobalVar.glava.inform.visible = true
	GlobalVar.glava.inform.text = "Починка началась и скоро будет окончена!"
	await get_tree().create_timer(2).timeout
	GlobalVar.glava.inform.visible = false
		
	GlobalVar.disable_all_drag = true
	for i in range(120):
		time -= 1
		await get_tree().create_timer(0.01).timeout

	GlobalVar.faults += 1
	#update_fault_label()
	
	GlobalVar.disable_all_drag = false 
	var green_style = StyleBoxFlat.new()
	green_style.bg_color = Color.GREEN
	panel.add_theme_stylebox_override("panel", green_style)
	
	var blok = select_blok()
	if blok and blok.get_parent():
		blok.visible = false

func check_once():
	if GlobalVar.random == 0:
		return
	
	randomize()
	var is_broken = random1 < 50  # true если <50, false если >=50
	return is_broken
	
func _on_body_entered(body):
	if body.name == "Viewport":
		
		call_deferred("_deferred_move")
		await get_tree().create_timer(0.01).timeout
		if phone != null:
			phone.check_faults_fix()
			
	if body.name == "Pochinka" and is_panel_color(select_self(), Color.RED):
		return
	elif body.name == "Pochinka" and is_panel_color(select_self(), Color.YELLOW):
		start_remont_detail()
		GlobalVar.coins -= randi_range(25, 50)
	elif body.name == "Pochinka" and is_panel_color(select_self(), Color.GREEN):
		return
		
func _deferred_move():
	dragging = false
	
	get_parent().remove_child(self)
	GlobalVar.panel.add_child(self)
	if is_panel_color(select_self(), Color.GREEN):
		GlobalVar.panels_parts.append(self)
	position = ordinata
	
	if is_in_group("batteryui"):
		GlobalVar.battery.visible = true		
	elif is_in_group("processorui"):
		GlobalVar.processor.visible = true
	elif is_in_group("speakerui"):
		GlobalVar.speaker.visible = true
	elif is_in_group("cameraui"):
		GlobalVar.camera.visible = true
