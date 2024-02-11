extends Control

signal shop_item_pressed

@onready var sneakers:Control = $Sneakers

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func init_all(price_dict, count_dict, description_dict):
	update_sprites(count_dict)
	for key in count_dict:
		var item_name:String = key
		var node = get_node(NodePath(item_name))
		if price_dict:
			node.init(item_name, price_dict[item_name])
		else:
			node.init(item_name, null)
		node.set_description(description_dict[item_name])
		node.shop_item_pressed.connect(button_pressesd)


func button_pressesd(item_name):
	shop_item_pressed.emit(item_name)


func update_sprites(inventory):
	for key in inventory:
		var node:Control = get_node(key)
		var sprite:AnimatedSprite2D = node.get_node("Sprite")
		sprite.animation = key
		if inventory[key] == 0:
			sprite.frame = 0
		else:
			sprite.frame = 1
