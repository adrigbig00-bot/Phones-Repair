extends Label

func _process(_delta):
	text = "$" + str(GlobalVar.coins)
