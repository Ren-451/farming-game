extends Panel

var def_tex = preload("res://art/inv_bg/item_slot_default_background.png")
var emp_tex = preload("res://art/inv_bg/item_slot_empty_background.png")
var select_tex = preload("res://art/inv_bg/item_slot_selected_background.png")

var def_style : StyleBoxTexture = null
var emp_style : StyleBoxTexture = null
var select_style : StyleBoxTexture = null 

var iClass = preload("res://scenes/item.tscn")
var item = null
var slot_index
var slot_type

enum SlotType {
	HOTBAR = 0,
	INVENTORY
}

func _ready():
	def_style = StyleBoxTexture.new()
	emp_style = StyleBoxTexture.new()
	select_style = StyleBoxTexture.new()
	def_style.texture = def_tex
	emp_style.texture = emp_tex
	select_style.texture = select_tex
	
	#if randi() % 2 == 0:
		#item = iClass.instantiate()
		#add_child(item)
	refstyle()
	
func refstyle():
	if SlotType.HOTBAR == slot_type and PlayerInventory.active_item_slot == slot_index:
		set('theme_override_styles/panel', select_style)
	elif item == null:
		set('theme_override_styles/panel', emp_style)
	else:
		set('theme_override_styles/panel', def_style)
		
func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("UserInterface")
	inventoryNode.add_child(item)
	item = null
	refstyle()

func putIntoSlot(new_item):
	item = new_item
	item.position = Vector2 (0 ,0)
	var inventoryNode = find_parent("UserInterface")
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
