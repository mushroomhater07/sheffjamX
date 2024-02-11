extends Node2D


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		var consumable : Consumable = get_child(0)
		consumable.use()
