extends CharacterBody2D

var speed = 100

var player_state

@onready var animated_sprite = $AnimatedSprite2D
@onready var pickup_zone = $PickupZone

func _physics_process(_delta):
	var dir = Input.get_vector("left", "right", "up", "down")
	
	if dir.x == 0 and dir.y ==0:
		player_state = "idle"
	elif dir.x != 0 or dir.y !=0:
		player_state = "walk"
		
	velocity = dir * speed
	move_and_slide()
	
	play_anim(dir)

func play_anim(dir):
	if player_state == "idle":
		if dir.y == -1:
			$AnimatedSprite2D.play("idle_north")
		if dir.x == 1:
			$AnimatedSprite2D.play("idle_east")
		if dir.y == 1:
			$AnimatedSprite2D.play("idle_south")
		if dir.x == -1:
			$AnimatedSprite2D.play("idle_west")
	
	if player_state == "walk":
		if dir.y == -1:
			$AnimatedSprite2D.play("walk_north")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk_east")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk_south")
		if dir.x == -1:
			$AnimatedSprite2D.play("walk_west")
		
func player():
	pass

func _input(event):
	if event.is_action_pressed("interact"):
		if pickup_zone.items_in_range.size() > 0:
			var pickup_item = pickup_zone.items_in_range.size()[0]
			pickup_item.being_picked_up(self)
			pickup_zone.items_in_range.erase(pickup_item)[1]
