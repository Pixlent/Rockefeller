extends Node

func load_json(file_path: String):
	var file_data := FileAccess.open(file_path, FileAccess.READ)

	return JSON.parse_string(file_data.get_as_text())
