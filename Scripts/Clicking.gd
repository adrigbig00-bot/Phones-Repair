extends Area3D

func _ready() -> void:
	GlobalVar.update_ui_references()

func _input_event(_camera: Camera3D, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	
	if GlobalVar.is_osmotr == true:
		return
	
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		if event.is_pressed():
			
			# Проверка для процессора
			if is_in_group("processor"):
				# Если процессор НЕ сломан — не даём кликнуть
				if not GlobalVar.brok_proc.visible and GlobalVar.phone != null:
					print("⚠️ Процессор уже целый, нельзя взять!")
					return
				if GlobalVar.processor_ui and is_instance_valid(GlobalVar.processor_ui):
					visible = false
					# if GlobalVar.processor_ui != null:
					GlobalVar.processor_ui.get_parent().remove_child(GlobalVar.processor_ui)
					GlobalVar.grid_container.add_child(GlobalVar.processor_ui)
					#else:
						#GlobalVar.purchase_processor.get_parent().remove_child(GlobalVar.purchase_processor)
						#GlobalVar.grid_container.add_child(GlobalVar.purchase_processor)
			
			# Проверка для динамика
			elif is_in_group("speaker"):
				if not GlobalVar.brok_speak.visible and GlobalVar.phone != null:
					print("⚠️ Динамик уже целый, нельзя взять!")
					return
				if GlobalVar.speaker_ui and is_instance_valid(GlobalVar.speaker_ui):
					visible = false
					GlobalVar.speaker_ui.get_parent().remove_child(GlobalVar.speaker_ui)
					GlobalVar.grid_container.add_child(GlobalVar.speaker_ui)
			
			# Проверка для батареи
			elif is_in_group("battery"):
				if not GlobalVar.brok_bat.visible and GlobalVar.phone != null:
					print("⚠️ Батарея уже целая, нельзя взять!")
					return
				if GlobalVar.battery_ui and is_instance_valid(GlobalVar.battery_ui):
					visible = false
					GlobalVar.battery_ui.get_parent().remove_child(GlobalVar.battery_ui)
					GlobalVar.grid_container.add_child(GlobalVar.battery_ui)
			
			# Проверка для камеры
			elif is_in_group("camera"):
				if not GlobalVar.brok_cam.visible and GlobalVar.phone != null:
					print("⚠️ Камера уже целая, нельзя взять!")
					return
				if GlobalVar.camera_ui and is_instance_valid(GlobalVar.camera_ui):
					visible = false
					GlobalVar.camera_ui.get_parent().remove_child(GlobalVar.camera_ui)
					GlobalVar.grid_container.add_child(GlobalVar.camera_ui)
