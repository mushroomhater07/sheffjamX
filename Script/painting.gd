extends Node2D

var time : float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	time += delta
	position.y += sin(time * 4) * 1

func set_painting(location):
	# Create an HTTP request node and connect its completion signal.
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._http_request_completed)
	var error = http_request.request(location)
	if error != OK:
		print("An error occurred in the HTTP request.")
		set_texture("res://Assets/painting.png")

## Called when the HTTP request is completed.
#func _http_request_completed(result, response_code, headers, body):
	#if result != HTTPRequest.RESULT_SUCCESS:
		#push_error("Image couldn't be downloaded. Try a different image.")
#
	#var image = Image.new()
	#var error = image.load_png_from_buffer(body)
	#if error != OK:
		#push_error("Couldn't load the image.")
#
	#var texture = ImageTexture.create_from_image(image)
#
	## Display the image in a TextureRect node.
	#var texture_rect = TextureRect.new()
	#add_child(texture_rect)
	#texture_rect.texture = texture

func _on_area_2d_area_entered(area):

	var player : Player = area.get_parent()
	player.max_speed *= 0.9
	clampf(player.max_speed, 125, 300)
	
	queue_free()
