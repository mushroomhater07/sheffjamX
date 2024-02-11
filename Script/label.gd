extends HBoxContainer
@onready var control = $Control
var label_1 : Label 
var label_2 : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
func setlabel1(text1):
	label_1 = get_child(0).get_child(0)
	control.get_child(0).set_text(str(text1))

#func setlabel2(text1 : String):
	#label_2.text = text1
# Called every frame. 'delta' is the elapsed time since the previous frame.

