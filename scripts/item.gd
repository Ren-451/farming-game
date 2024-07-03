extends Node2D

@onready var texture_rect = $TextureRect
@onready var label = $Label

var item_name
var item_quantity

func _ready():
	var rand_val = randi() % 2
	if rand_val == 0:
		item_name = "Egg"
	else:
		item_name = "Empty Glass"
	
	texture_rect.texture = load("res://items/" + item_name + ".png")
	var stack_size = int(Jsondata.item_data[item_name]["StackSize"])
	item_quantity = randi() % stack_size + 1
	
	if stack_size == 1:
		label.visible = false
	else:
		label.text = str(item_quantity)

func add_item_quantity(amount_to_add):
	item_quantity += amount_to_add
	label.text = str(item_quantity)

func decrease_item_quantity(amount_to_remove):
	item_quantity -= amount_to_remove
	label.text = str(item_quantity)
