extends Node
class_name Consumable

# Consumable variables
var description : String
var price : int
var is_powerup : bool
var powerup_duration : float

# Consumble use function - to be implemented by each child
func use():
	print("You need to implement this")
