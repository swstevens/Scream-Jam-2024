extends Label

func _input(event):
	if event.is_action_pressed("move") == false:
		return
	var bounds = get_rect()
	if bounds.has_point(event.position):
		print("clicked!")
