extends Camera2D

const ZOOM_UPPER_BOUND := 10
const ZOOM_LOWER_BOUND := 1
const ZOOM_SPEED := 5
const ZOOM_OUT_SPEED := 10
const ZOOM_IN_SPEED := 5

var new_zoom := zoom.x
var new_position := position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	# Zoom logic
	if event is InputEventMouseButton:
		if event.is_released():
			return
		
		var input_zoom = Input.get_axis("mouse_scroll_up", "mouse_scroll_down")
		
		if input_zoom == -1 and new_zoom >= ZOOM_UPPER_BOUND: input_zoom = 0
		if input_zoom == 1 and new_zoom <= ZOOM_LOWER_BOUND: input_zoom = 0
		
		new_zoom -= input_zoom
		
	# Movement logic
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			new_position -= event.relative / zoom

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if new_zoom > zoom.x:
		zoom.x = lerp(zoom.x, new_zoom, ZOOM_IN_SPEED*delta)
	else:
		zoom.x = lerp(zoom.x, new_zoom, ZOOM_OUT_SPEED*delta)

	zoom.y = zoom.x
	
	position = new_position

	pass
