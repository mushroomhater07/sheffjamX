extends Control

var money:float = 1000

var current_shop_items:Array = ["Sneakers", "Hammer", "Flashbang", "LightsOut", "SpeedBoost"]

var player_inventory:Dictionary = {}
var prices:Dictionary = {}
var descriptions:Dictionary = {}

var player_page:Control
var shop_page:Control


var selected_item = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	read_playerdata()
	read_gamedata()
	
	
	player_page = load("res://Scenes/ShopGUI/shop_player_inventory.tscn").instantiate()
	add_child(player_page)
	player_page.init()
	
	shop_page = load("res://Scenes/ShopGUI/shop_inventory.tscn").instantiate()
	add_child(shop_page)
	shop_page.init()
	
	player_page.set_money(money)
	shop_page.get_node("ShopInventoryConsumables").shop_item_pressed.connect(item_buy)
	shop_page.get_node("ShopInventoryConsumables").select_button_pressed.connect(select_button_pressed)
	player_page.get_node("ShopInventoryConsumables").select_button_pressed.connect(select_button_pressed)
	player_page.new_game.connect(new_game)


func init(additional_money):
	money += additional_money
	player_page.set_money(money)
	print(money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func read_gamedata():
	var datafile = JSON.parse_string(FileAccess.open("res://data/gamedata.json",FileAccess.READ).get_as_text())
	var consumables = datafile["consumable"]
	for i in range(len(consumables)):
		var item_dict:Dictionary = consumables[i]
		for key in item_dict:
			if key in current_shop_items:
				var data_dict = item_dict[key]
				descriptions[key] = data_dict["descpt"]
				prices[key] = data_dict["price"]
	

func store_gamedata():
	var datafile = JSON.parse_string(FileAccess.open("res://data/gamedata.json",FileAccess.READ).get_as_text())
	var consumables:Array = datafile["consumable"]
	for i in range(len(consumables)):
		var item_dict:Dictionary = consumables[i]
		for key in item_dict:
			if key in current_shop_items:
				var data_dict = item_dict[key]
				data_dict["descpt"] = descriptions[key]
				data_dict["price"] = prices[key]
				consumables[i] = data_dict
				
	
	datafile["consumable"] = consumables
	

func read_playerdata():
	var datafile = JSON.parse_string(FileAccess.open("user://userdata.json",FileAccess.READ).get_as_text())
	var inventory:Dictionary = datafile["all_time_stat"]
	for key in inventory:
		if key in current_shop_items:
			player_inventory[key] = inventory[key]
	
	var current_stats = datafile["current_stat"]
	money = current_stats["money"]
	selected_item = datafile["selected"]

func store_playerdata():
	var datafile = JSON.parse_string(FileAccess.open("user://userdata.json",FileAccess.READ).get_as_text())
	var inventory:Dictionary = datafile["all_time_stat"]
	for key in inventory:
		if key in current_shop_items:
			inventory[key] = player_inventory[key]
	datafile["all_time_stat"] = inventory
	
	datafile["current_stat"]["money"] = money
	datafile["selected"] = selected_item
	
	FileAccess.open("user://userdata.json", FileAccess.WRITE).store_string ( JSON.stringify(datafile))
	



func item_buy(item_name):
	if prices[item_name] > money:
		print("cant afford!")
		return
	if player_inventory[item_name]>0:
		print("already owned!")
		return
	
	print("available to buy")
	money -= prices[item_name]
	update_money()
	
	#shop_inventory[item_name] -= 1
	shop_page.get_node("ShopInventoryConsumables").get_node(item_name).sold()
	
	player_inventory[item_name] += 1
	player_page.get_node("ShopInventoryConsumables").update_sprites(player_inventory, true)
	player_page.get_node("ShopInventoryConsumables").update_select_buttons(selected_item)
	
	

func update_money():
	player_page.set_money(money)

func select_button_pressed(item_name):
	print("select button pressed")
	selected_item = item_name
	player_page.get_node("ShopInventoryConsumables").update_select_buttons(item_name)

func new_game():
	print("starting new game")
	store_playerdata()
	
	var museum_game = load("res://Scenes/museum_game.tscn").instantiate()
	get_parent().add_child(museum_game)
	queue_free()
	museum_game.get_node("Player/PlayerCharacter").init(selected_item)
