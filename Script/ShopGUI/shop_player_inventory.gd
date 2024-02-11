extends Control

signal new_game

@onready var shop = get_node("../../Shop")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init():
	$ShopInventoryConsumables.init_all(shop.current_shop_items, null, shop.player_inventory, shop.descriptions, true)

func set_money(money):
	$Money.text = "£"+str(money)


		


func _on_new_game_button_pressed():
	##### new game
	new_game.emit()
