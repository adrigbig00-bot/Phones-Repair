extends Node3D

var phone

var faults : int = 0

var broken_parts = []
var panels_parts = []

var battery_ui
var processor_ui
var speaker_ui
var camera_ui

var coins : int = 400

var elements

var is_osmotr : bool = false

var purchase_battery 
var purchase_processor  
var purchase_speaker  
var purchase_camera 

var disable_all_drag = false

var random 
var is_config = false

var panbat
var panproc
var panspeak
var pancam

var glava

var battery
var processor
var speaker
var camera

var grid_container
var panel

var brok_bat 
var brok_proc
var brok_speak
var brok_cam

var count_in_panel : int = 0

# Функция для обновления ссылок (вызови её один раз, когда UI загружен)
func update_ui_references():
	phone = get_parent()
	
	battery_ui = get_tree().get_first_node_in_group("batteryui")
	processor_ui = get_tree().get_first_node_in_group("processorui")
	speaker_ui = get_tree().get_first_node_in_group("speakerui")
	camera_ui = get_tree().get_first_node_in_group("cameraui")
	
	grid_container = get_tree().get_first_node_in_group("inventory")
	panel = get_tree().get_first_node_in_group("panel")
	
	battery = get_tree().get_first_node_in_group("battery")
	processor = get_tree().get_first_node_in_group("processor")
	speaker = get_tree().get_first_node_in_group("speaker")
	camera = get_tree().get_first_node_in_group("camera")
	
	panbat = get_tree().get_first_node_in_group("panbat")
	panproc = get_tree().get_first_node_in_group("panproc")
	panspeak = get_tree().get_first_node_in_group("panspeak")
	pancam = get_tree().get_first_node_in_group("pancam")
	
	purchase_battery = get_tree().get_first_node_in_group("purch_bat")
	purchase_processor = get_tree().get_first_node_in_group("purch_proc")
	purchase_speaker = get_tree().get_first_node_in_group("purch_speak")
	purchase_camera = get_tree().get_first_node_in_group("purch_cam")
	
	brok_bat = get_tree().get_first_node_in_group("brok_bat")
	brok_proc = get_tree().get_first_node_in_group("brok_proc")
	brok_speak = get_tree().get_first_node_in_group("brok_speak")
	brok_cam = get_tree().get_first_node_in_group("brok_cam")
	
	glava = get_tree().get_first_node_in_group("glava")
	
	random = randi_range(1, 3)
