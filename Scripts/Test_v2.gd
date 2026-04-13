extends Node3D

func _ready() -> void:
	await get_tree().create_timer(2.3).timeout
	
	if GlobalVar.processor_ui.get_parent() == GlobalVar.processor:
		GlobalVar.purchase_processor.get_parent().remove_child(GlobalVar.purchase_processor)
		GlobalVar.panel.add_child(GlobalVar.purchase_processor)
		
	if GlobalVar.processor_ui.get_parent() == GlobalVar.grid_container:
		GlobalVar.purchase_processor.get_parent().remove_child(GlobalVar.purchase_processor)
		GlobalVar.grid_container.add_child(GlobalVar.purchase_processor)
	GlobalVar.processor_ui.queue_free()
	GlobalVar.brok_proc.visible = false
	
		#var speaker_ui = GlobalVar.speaker_ui.duplicate()
		#speaker_ui.name = "SpeakerUI"
		#GlobalVar.grid_container.add_child(speaker_ui)
		#GlobalVar.purchased_speaker.append(speaker_ui)
