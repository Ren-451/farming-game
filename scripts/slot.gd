extends Panel

var def_tex = preload("res://art/inv_bg/item_slot_default_background.png")
var emp_tex = preload("res://art/inv_bg/item_slot_empty_background.png")

var def_style: StyleBoxTexture = null
var emp_style: StyleBoxTexture = null

var iClass = preload("res://scenes/item.tscn")
var item = null

func _ready():
	def_style = StyleBoxTexture.new()
	emp_style = StyleBoxTexture.new()
	def_style.texture = def_tex
	emp_style.texture = emp_tex
	
	#if randi() % 2 == 0:
		#item = iClass.instantiate()
		#add_child(item)
	refstyle()
	
func refstyle():
	if item == null:
		set('theme_override_styles/panel', emp_style)
	else:
		set('theme_override_styles/panel', def_style)
		
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null
	refstyle()

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2 (0 ,0)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.remove_child(item)
	add_child(item)
	refstyle()	

func initialize_item(item_name, item_quantity):
	if item == null:
		item = iClass.instantiate()
		add_child(item)
		item.set_item(item_name, item_quantity)
	else:
		item.set_item(item_name, item_quantity)
	refstyle()
