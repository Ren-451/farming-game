extends CharacterBody2D

var speed = 100

var player_state

@onready var animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
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
