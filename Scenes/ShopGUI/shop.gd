extends Control

var money:float = 1000

var player_inventory:Dictionary =  {"Sneakers":0,
									"Hammer":0,
									"Flashbang":0}
var shop_inventory:Dictionary ={"Sneakers":1,
								"Hammer":1,
								"Flashbang":1}
var prices:Dictionary =    {"Sneakers":100,
							"Hammer":200,
							"Flashbang":500}
var descriptions:Dictionary =  {"Sneakers":"sneakers description",
								"Hammer":"Hammer description",
								"Flashbang":"Flashbang description"}


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShopPlayerInventory.set_money(money)
	$ShopInventory/ShopInventoryConsumables.shop_item_pressed.connect(item_buy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func item_buy(item_name):
	if prices[item_name] > money:
		print("cant afford!")
		return
	if shop_inventory[item_name] <= 0:
		print("out of stock")
		return
	
	print("Bought " + item_name)
	money -= prices[item_name]
	update_money()
	
	shop_inventory[item_name] -= 1
	$ShopInventory/ShopInventoryConsumables.get_node(item_name).sold()
	
	player_inventory[item_name] += 1
	$ShopPlayerInventory/ShopInventoryConsumables.update_sprites(player_inventory)
	
	

func update_money():
	$ShopPlayerInventory.set_money(money)
