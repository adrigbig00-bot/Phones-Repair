extends StaticBody3D

enum PhoneFault {BATTERY, PROCESSOR, SPEAKER, CAMERA}

var current_fault : PhoneFault

@export var camera_classic : Camera3D
@export var camera_master : Camera3D

var mnojitel : float = 1.0

var last_part = null

var dragbody = false
var last_pos = Vector2()

func lit():
	if camera_classic.current:
		
		#Input.mouse_mode = Input.MOUSE_MODE_CONFINED
		await get_tree().create_timer(0.01).timeout
		select_random_faults()
		
		check_faults_fix()

func _ready() -> void: 
	lit()

func check_faults_fix():
	if GlobalVar.broken_parts == null or GlobalVar.panels_parts == null:
		return
		
	# Проверяем, все ли поломки починены
	if GlobalVar.broken_parts.size() == GlobalVar.panels_parts.size():
		GlobalVar.faults = 0
		GlobalVar.is_config = true
		is_confined()
		GlobalVar.is_config = false
			
func _input(event: InputEvent) -> void:
	if GlobalVar.is_osmotr == false:
		return
	else:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			dragbody = event.is_pressed()
			last_pos = event.position
			
		if event is InputEventMouseMotion and dragbody:
			var delta = event.position - last_pos
			rotate_y(-delta.x * 0.005)
			last_pos = event.position
	#await get_tree().create_timer(3).timeout
	#GlobalVar.is_osmotr = false

func select_color(panel, is_broken):
	var style = StyleBoxFlat.new()
	style.bg_color = Color.RED if is_broken else Color.YELLOW
	panel.add_theme_stylebox_override("panel", style)

func select_random_faults():
	if GlobalVar.is_config == true:
		return
	
	randomize()
	var all_faults = PhoneFault.values()
	all_faults.shuffle()
	
	var selected_faults = []
	
	for i in range(GlobalVar.random):
		current_fault = all_faults[i]
		
		selected_faults.append(PhoneFault.keys()[current_fault])
		spawn_parts_based_on_fault()
		
	print("📱 Телефон имеет ", GlobalVar.random, " поломки. Каких - неизвестно ")
	
func spawn_parts_based_on_fault():
	if GlobalVar.is_config == true:
		return
	
	# Показываем только нужную сломанную деталь
	match current_fault:
		PhoneFault.BATTERY:
			$Battery/Broken_Battery.visible = true
			var is_broken = GlobalVar.battery_ui.check_once()
			if is_broken == true:
				print("Нужно покупать новую батарейку!")
			else:
				print("Батарейку всё ещё можно починить!")
			GlobalVar.broken_parts.append(GlobalVar.battery_ui)
			select_color(GlobalVar.panbat, is_broken)
		PhoneFault.PROCESSOR:
			$Processor/Broken_Processor.visible = true
			var is_broken = GlobalVar.processor_ui.check_once()
			if is_broken == true:
				print("Нужно покупать новый процессор!")
			else:
				print("Процессор всё ещё можно починить!")
			GlobalVar.broken_parts.append(GlobalVar.processor_ui)
			select_color(GlobalVar.panproc, is_broken)
		PhoneFault.SPEAKER:
			$Speaker/Broken_Speaker.visible = true
			var is_broken = GlobalVar.speaker_ui.check_once()
			if is_broken == true:
				print("Нужно покупать новый динамик!")
			else:
				print("Динамик всё ещё можно починить!")
			GlobalVar.broken_parts.append(GlobalVar.speaker_ui)	
			select_color(GlobalVar.panspeak, is_broken)
		PhoneFault.CAMERA:
			$Camera/Broken_Camera.visible = true
			var is_broken = GlobalVar.camera_ui.check_once()
			if is_broken == true:
				print("Нужно покупать новую камеру!")
			else:
				print("Камеру всё ещё можно починить!")
			GlobalVar.broken_parts.append(GlobalVar.camera_ui)
			select_color(GlobalVar.pancam, is_broken)

func is_confined():
		if GlobalVar.is_config:
			GlobalVar.panels_parts.clear()
			GlobalVar.broken_parts.clear()
			GlobalVar.glava.inform.visible = true
			GlobalVar.glava.inform.text = "Поломка устранена, перенаправление в мастерскую!"
			await get_tree().create_timer(2.5).timeout
			GlobalVar.glava.inform.visible = false
			GlobalVar.glava.camera.current = true
			GlobalVar.glava.clascamera.current = false
			GlobalVar.glava.osnova.visible = false
			GlobalVar.glava.GoPlay.visible = true
			GlobalVar.is_osmotr = false
			GlobalVar.glava.osmotr1.visible = true
			GlobalVar.glava.osmotr2.visible = false
			randomize()
			GlobalVar.random = randi_range(1, 3)
			await get_tree().create_timer(0.5).timeout
			GlobalVar.coins += 300
