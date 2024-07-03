extends Node

var item_data : Dictionary

func _ready():
	item_data = load_data("res://Data/ItemData.json")
	
#func load_data(file_path):
	#
	#var file_data = FileAccess.open(file_path, FileAccess.READ)
	#var json_data = JSON.new()
	#json_data.parse(file_data.get_as_text())
	#file_data.close()
	#return json_data.get_data()

func load_data(file_path : String):
	var file_data = FileAccess.get_file_as_string(file_path)
	var json_data = JSON.parse_string(file_data)
	return json_data
