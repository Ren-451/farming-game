extends Node2D

const SlotClass = preload("res://scripts/slot.gd")
@onready var inv_slots = $GridContainer
var hold_item = null

func _ready():
	for inv_slot in inv_slots.get_children():
		inv_slot.gui_input.connect(slot_gui_input.bind(inv_slot))

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if hold_item != null:
				# empty slot
				if !slot.item:
					slot.putIntoSlot(hold_item)
					hold_item = null
				# slot already contains an item
				else:
					# Different items ; swap
					if hold_item.item_name != slot.item.item_name:
						var temp_item = slot.item
						slot.pickFromSlot()
						temp_item.global_position = event.global_position
						slot.putIntoSlot(hold_item)
						hold_item = temp_item
					
					#Same item, merge
					else:
						var stack_size = int(Jsondata.item_data[slot.item.item_name]["StackSize"])
						var able_to_add = stack_size - slot.item.item_quantity
						if able_to_add >= hold_item.item_quantity:
							slot.item.add_item_quantity(hold_item.item_quantity)
							hold_item.queue_free()
							hold_item = null
						
						else:
							slot.item.add_item_quantity(able_to_add)
							hold_item.decrease_item_quantity(able_to_add)
			# not holding item
			elif slot.item:
				hold_item = slot.item
				slot.pickFromSlot()
				hold_item.global_position = get_global_mouse_position()

func _input(_event):
	if hold_item:
		hold_item.global_position = get_global_mouse_position()
		
