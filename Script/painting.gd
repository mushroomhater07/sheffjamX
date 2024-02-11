extends Node2D

var time : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	position.y += sin(time * 4) * 1

func _ready():
	var datafile :Dictionary = JSON.parse_string(FileAccess.open("res://data/gamedata.json",FileAccess.READ).get_as_text())
	#print(randi() % len(datafile.painting))
	#print()
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	var error = http_request.request(datafile.painting[randi() % len(datafile.painting)])
	if error != OK:
		print("An error occurred in the HTTP request.")
		get_child(0).set_texture(load("res://Assets/painting.png"))

func _http_request_completed(result, response_code, headers, body):
	if result != HTTPRequest.RESULT_SUCCESS:
		print("Image couldn't be downloaded. Try a different image.")
		get_child(0).set_texture(load("res://Assets/painting.png"))
	var image = Image.new()
	var error = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image.")
		get_child(0).set_texture("res://Assets/painting.png")
		get_child(0).set_texture(load("res://Assets/painting.png"))
	get_child(0).set_texture(ImageTexture.create_from_image(image))
	get_child(0).set_scale(Vector2(0.0266666,0.02666666))
	
func _on_area_2d_area_entered(area):

	var player : Player = area.get_parent()
	player.max_speed *= 0.9
	clampf(player.max_speed, 125, 300)
	
	queue_free()
