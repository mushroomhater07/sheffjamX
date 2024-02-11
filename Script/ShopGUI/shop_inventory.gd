extends Control

signal shop_item_pressed

@onready var shop = get_node("../../Shop")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func init():
	var shop_stock:Dictionary = {}
	for key in shop.player_inventory:
		if shop.player_inventory[key] == 0:
			shop_stock[key] = 1
		else:
			shop_stock[key] = 0
	$ShopInventoryConsumables.init_all(shop.current_shop_items, shop.prices, shop_stock, shop.descriptions, false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



	
