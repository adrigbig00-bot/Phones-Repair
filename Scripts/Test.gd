extends Node3D

@onready var old_phone = $Phone
@onready var phone_scene = preload("res://Assets/Models/Phone_system.tscn")

func _ready() -> void:
	await get_tree().create_timer(20.0).timeout
	old_phone.queue_free()
	
	# Очищаем инвентарь
	for item in GlobalVar.grid_container.get_children():
		item.queue_free()
	for child in GlobalVar.panel.get_children():
		child.queue_free()
	
	await get_tree().create_timer(5.0).timeout
	var phone = phone_scene.instantiate()
	add_child(phone)
	
	# Обновляем ссылки после создания телефона
	reset_phone_data()
	
	await get_tree().create_timer(21.0).timeout
	phone.queue_free()
	
	for item in GlobalVar.grid_container.get_children():
		item.queue_free()
	for child in GlobalVar.panel.get_children():
		child.queue_free()
	
	await get_tree().create_timer(10.0).timeout
	var phone1 = phone_scene.instantiate()
	add_child(phone1)
	
	reset_phone_data()  # снова сброс
	
func reset_phone_data():
	print("🔄 Сбрасываем данные для нового телефона")
	
	# Очищаем списки
	GlobalVar.broken_parts.clear()
	GlobalVar.panels_parts.clear()
	GlobalVar.faults = 0
