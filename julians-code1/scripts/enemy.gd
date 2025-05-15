extends CharacterBody2D
var player_chase = false
var player = null
var speed = 80 
var health = 100
var player_inattack_zone = false
var can_take_damage = true


func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	if player_chase:
		position += (player.position - position)/speed

func _on_detection_area_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false
	print  ("stop playerchase")


func _on_detection_area_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true
	print ("start playerchase")
	
	
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
		
func enemy():
	pass

func _on_hit_area_body_entered(body: Node2D) -> void:
	print ("player took dmg")


func _on_enemy_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false


func _on_enemy_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_inattack_zone = false
		

func deal_with_damage():
	if player_inattack_zone and global.palyer_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("gegner health = ", health)
			if health <= 0:
				self.queue_free()
			


func _on_take_damage_cooldown_timeout() -> void:
	can_take_damage = true
