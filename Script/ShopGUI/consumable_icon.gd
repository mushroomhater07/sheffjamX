extends Control

signal shop_item_pressed

signal select_button_pressed

var item_name:String

# Called when the node enters the scene tree for the first time.
func _ready():
	$SelectButton.select_button_pressed.connect(on_select_button_pressed)


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
	$SoldLabel.set_visible(true)


func _on_consumable_button_pressed():
	shop_item_pressed.emit(item_name)

func on_select_button_pressed():
	select_button_pressed.emit(item_name)
	
