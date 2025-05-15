extends CharacterBody2D


var enemy_inattack_range = false
var enemy_attack_cooldown = true
var speed: float = 450.0
var health = 100
var player_alive = true


func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	update_health()
	enemy_attack()
	
	
	if health <= 0:
		player_alive = false
		print("player ist tod")
		#self.queue_free()

	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")

	if input_vector.length() > 0:
		input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
	
func _on_regin_timer_timeout() -> void:
	if health < 100:
		health = health +0.25
		if health > 100:
				health = 100
	if health <= 0:
		health = 0
		health = 0 
		
		
		


func player():
	pass

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = true

func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true: 
		health -= 1
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_inattack_range = false


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
