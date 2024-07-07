extends Node

const SlotClass = preload("res://scripts/slot.gd")
const iClass = preload("res://scripts/item.gd")
const NUM_INV_SLOTS = 36

var inventory = {
	0: ['Empty Glass', 1], # slot_index : [item_name, item_quantity]
	1: ['Empty Glass', 1]

}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			# checks if slot is full
			inventory[item][1] += item_quantity
			return
			
	# if item does not exist in the inventory (add to empty slot)
	for i in range(NUM_INV_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			return

func remove_item(slot : SlotClass):
	inventory.erase(slot.slot_index)

func add_item_to_empty_slot(item : iClass, slot : SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]

func add_item_quantity(slot : SlotClass, quantity_to_add : int):
	inventory[slot.slot_index][1] += quantity_to_add
