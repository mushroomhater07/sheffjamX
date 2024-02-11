extends Control

signal shop_item_pressed

var item_name:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_description(new_description):
	$Description.text = new_description

func set_price(price):
	if not price:
		$Price.text = ""
	else:
		$Price.text = "£"+str(price)

func init(new_item_name, price):
	item_name = new_item_name
	$Name.text = new_item_name
	set_price(price)

func sold():
	print(item_name+" sold")
	$SoldLabel.set_visible(true)


func _on_consumable_button_pressed():
	print("pressed")
	shop_item_pressed.emit(item_name)
