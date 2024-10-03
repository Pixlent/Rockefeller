extends Camera2D

const ZOOM_UPPER_BOUND := 10
const ZOOM_LOWER_BOUND := 1
const ZOOM_SPEED := 5
const ZOOM_OUT_SPEED := 10
const ZOOM_IN_SPEED := 5

var new_zoom := zoom.x
var new_position := position

func _input(event: InputEvent):
	var hovered_control = get_viewport().gui_get_hovered_control()
	
	if hovered_control:
		if hovered_control.is_in_group("interactive_ui"):
			return
	
	_handle_focus(event)
	_handle_zoom(event)
	_handle_movement(event)

func _handle_focus(event: InputEvent):
	if event is InputEventMouseButton:
		if event.double_click:
			_focus(get_global_mouse_position())

func _handle_zoom(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_released():
			return
		
		var input_zoom = Input.get_axis("mouse_scroll_up", "mouse_scroll_down")
		
		if input_zoom == -1 and new_zoom >= ZOOM_UPPER_BOUND: input_zoom = 0
		if input_zoom == 1 and new_zoom <= ZOOM_LOWER_BOUND: input_zoom = 0
		
		new_zoom -= (input_zoom * 0.2) * new_zoom

func _handle_movement(event: InputEvent):
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			new_position -= event.relative / zoom

func _process(delta):
	if new_zoom > zoom.x:
		zoom.x = lerp(zoom.x, new_zoom, ZOOM_IN_SPEED*delta)
	else:
		zoom.x = lerp(zoom.x, new_zoom, ZOOM_OUT_SPEED*delta)
	
	zoom.y = zoom.x
	position = new_position

func _focus(_target_position: Vector2):
	new_position = _target_position
