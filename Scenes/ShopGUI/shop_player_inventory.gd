extends Control

@onready var shop = get_node("../../Shop")


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShopInventoryConsumables.init_all(null, shop.player_inventory, shop.descriptions)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_money(money):
	$Money.text = "£"+str(money)
