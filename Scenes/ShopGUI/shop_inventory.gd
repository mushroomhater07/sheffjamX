extends Control

signal shop_item_pressed

@onready var shop = get_node("../../Shop")



# Called when the node enters the scene tree for the first time.
func _ready():
	$ShopInventoryConsumables.init_all(shop.prices, shop.shop_inventory, shop.descriptions)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



	
