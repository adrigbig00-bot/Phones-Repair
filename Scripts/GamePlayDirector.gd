extends Node3D

@onready var camera = $Garash/CamMaster
@onready var osnova = $CanvasLayer/Control/Osnova
@onready var clascamera = $Camera3D
@onready var phone = $Phone
@onready var GoPlay = $CanvasLayer/Control/GoPlay
@onready var magazininvent = $CanvasLayer/Control/MagazInvent
@onready var inform = $CanvasLayer/Control/Information

@onready var osmotr1 = $CanvasLayer/Control/Osnova/Osmotr
@onready var osmotr2 = $CanvasLayer/Control/Osnova/Osmotr2

func _ready() -> void:
	if camera.current:
		osnova.visible = false
	elif not camera.current:
		osnova.visible = true
	get_tree().paused = true
	GoPlay.visible = false
	await get_tree().create_timer(2).timeout
	inform.visible = false
	get_tree().paused = false
	GoPlay.visible = true

func parent_item(item, panel, broken_item, cost, hoi):
	if item.is_panel_color(panel, Color.YELLOW) or broken_item.visible == false:
		return 
	
	if item.get_parent() != GlobalVar.grid_container:
		if GlobalVar.coins <= 0:
			return
		else:
			GlobalVar.coins -= cost
			broken_item.visible = false
			GlobalVar.panels_parts.append(item)
			inform.visible = true
			inform.text = str(hoi) + ": был(а) куплен(а) и улучшен(а) за " + str(cost) + "$"
			item.okraska(panel)
			phone.check_faults_fix()
			await get_tree().create_timer(2).timeout
			inform.visible = false
	else:
		inform.visible = true
		inform.text = "⚠️ Требуется убрать данный предмет из инвентаря!"
		await get_tree().create_timer(2).timeout
		inform.visible = false
		
func _on_go_play_pressed() -> void:
	osnova.visible = true
	clascamera.current = true
	camera.current = false
	await get_tree().create_timer(0.01).timeout
	phone.lit()
	GoPlay.visible = false
	
func _on_magazin_pressed() -> void:
	magazininvent.visible = true
	
func _on_processor_poc_pressed() -> void:
	parent_item(GlobalVar.processor_ui, GlobalVar.panproc, GlobalVar.brok_proc, 200, "Процессор")
	
func _on_battery_poc_pressed() -> void:
	parent_item(GlobalVar.battery_ui, GlobalVar.panbat, GlobalVar.brok_bat, 100, "Аккумулятор")

func _on_speaker_poc_pressed() -> void:
	parent_item(GlobalVar.speaker_ui, GlobalVar.panspeak, GlobalVar.brok_speak, 80, "Динамик")

func _on_camera_poc_pressed() -> void:
	parent_item(GlobalVar.camera_ui, GlobalVar.pancam, GlobalVar.brok_cam, 50, "Камера")

func _on_osmotr_pressed() -> void:
	GlobalVar.is_osmotr = true
	osmotr1.visible = false
	osmotr2.visible = true
	
func _on_osmotr_2_pressed() -> void:
	GlobalVar.is_osmotr = false
	osmotr1.visible = true
	osmotr2.visible = false
