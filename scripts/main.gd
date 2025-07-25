extends Node

func _ready() -> void:
	_update_aspect()
	get_tree().get_root().size_changed.connect(Callable(self, "_update_aspect"))
	get_viewport().size_changed.connect(Callable(self, "_update_aspect"))

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		_update_aspect()  

func _update_aspect() -> void:
	var size: Vector2i = DisplayServer.window_get_size()
	if !(size.x > 2.5*size.y or size.y > 2.5 * size.x):
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_EXPAND
	elif size.x/size.y < 2.5:
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP_HEIGHT
	else:
		get_tree().root.content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP_WIDTH
