extends Control

signal shop_item_pressed
signal select_button_pressed
@onready var shop = get_node("../../../Shop")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all(shop_items, price_dict, count_dict, description_dict, select_buttons):
	update_sprites(count_dict, select_buttons)
	for key in shop_items:
		var item_name:String = key
		var node = get_node(NodePath(item_name))
		if price_dict:
			node.init(item_name, price_dict[item_name])
		else:
			node.init(item_name, null)
		node.set_description(description_dict[item_name])
		node.shop_item_pressed.connect(button_pressesd)
		node.select_button_pressed.connect(on_select_button_pressed)
		
		
		if select_buttons:
			update_select_buttons(null, false)
		else:
			update_select_buttons(null, true)
	if shop.selected_item != "" and select_buttons:
		update_select_buttons(shop.selected_item)

func button_pressesd(item_name):
	shop_item_pressed.emit(item_name)
	on_select_button_pressed(item_name)


func update_sprites(inventory, player_inv):
	for key in inventory.keys():
		var node:Control = get_node(key)
		var sprite:AnimatedSprite2D = node.get_node("Sprite")
		sprite.animation = key
		if inventory[key] == 0  and not player_inv:
			sprite.frame = 1
			node.get_node("SoldLabel").set_visible(true)
		else:
			if inventory[key] == 0:
				sprite.frame = 0
			else:
				sprite.frame = 1

func update_select_buttons(selected, ignore_all=false):
	for item in shop.current_shop_items:
		var button_node:Control = get_node(item+"/SelectButton")
		if ignore_all:
			button_node.set_frame(2)
		else:
			if item == selected:
				button_node.set_frame(1)
			elif shop.player_inventory[item] > 0:
				button_node.set_frame(0)
			else:
				button_node.set_frame(2)

func on_select_button_pressed(item_name):
	var select_button = get_node(item_name+"/SelectButton/AnimatedSprite2D")
	if select_button.frame != 2:
		select_button_pressed.emit(item_name)
