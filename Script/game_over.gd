extends Node


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		var shop = load("res://Scenes/ShopGUI/shop.tscn").instantiate()
		add_child(shop)
