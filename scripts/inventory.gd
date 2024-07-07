extends Node2D

const SlotClass = preload("res://scripts/slot.gd")
@onready var inv_slots = $GridContainer
var hold_item = null

func _ready():
	var slots = inv_slots.get_children()
	for i in range(slots.size()):
		slots[i].gui_input.connect(slot_gui_input.bind(slots[i]))
		slots[i].slot_index = i
	initialize_inventory()

func initialize_inventory():
	var slots = inv_slots.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if hold_item != null:
				# empty slot
				if !slot.item:
					left_click_empty_slot(slot)
					
				# slot already contains an item
				else:
					# Different items ; swap
					if hold_item.item_name != slot.item.item_name:
						left_click_diff_item(event, slot)
					
					#Same item, merge
					else:
						left_click_same_item(slot)

			# not holding item
			elif slot.item:
				left_click_not_holding(slot)

func _input(_event):
	if hold_item:
		hold_item.global_position = get_global_mouse_position()
		

func left_click_empty_slot(slot : SlotClass):
	PlayerInventory.add_item_to_empty_slot(hold_item, slot)
	slot.putIntoSlot(hold_item)
	hold_item = null
	

func left_click_diff_item(event : InputEvent, slot : SlotClass):
	PlayerInventory.remove_item(slot)
	PlayerInventory.add_item_to_empty_slot(hold_item, slot)
	var temp_item = slot.item
	slot.pickFromSlot()
	temp_item.global_position = event.global_position
	slot.putIntoSlot(hold_item)
	hold_item = temp_item
	
func left_click_same_item(slot : SlotClass):
	var stack_size = int(Jsondata.item_data[slot.item.item_name]["StackSize"])
	var able_to_add = stack_size - slot.item.item_quantity
	if able_to_add >= hold_item.item_quantity:
		PlayerInventory.add_item_quantity(slot, hold_item.item_quantity)
		slot.item.add_item_quantity(hold_item.item_quantity)
		hold_item.queue_free()
		hold_item = null

	else:
		PlayerInventory.add_item_quantity(slot, able_to_add)
		slot.item.add_item_quantity(able_to_add)
		hold_item.decrease_item_quantity(able_to_add)

func left_click_not_holding(slot : SlotClass):
	PlayerInventory.remove_item(slot)
	hold_item = slot.item
	slot.pickFromSlot()
	hold_item.global_position = get_global_mouse_position()
