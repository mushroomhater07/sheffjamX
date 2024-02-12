extends Node

var amount

func init(victory, new_amount):
	amount = new_amount
	if victory:
		$Label.text = "You escaped!"

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		var shop = load("res://Scenes/ShopGUI/shop.tscn").instantiate()
		
		get_parent().add_child(shop)
		shop.init(amount)
		queue_free()

func _unhandled_input(event):
	pass
	#if event.is_action_pressed("ui_accept"):
		#var shop = load("res://Scenes/ShopGUI/shop.tscn").instantiate()
		#print("unhandled input")
		#add_child(shop)
