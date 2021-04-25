extends KinematicBody2D

enum STATES {IDLE, WALK, ATTACK, DIE}

signal dead
signal health_changed(health)

export var health := 5.0 setget set_health
export var lantern_max_time := -1

var speed := 75.0
var state : int = STATES.IDLE setget set_state
var prev_state : int = STATES.IDLE

var bullet_scene := preload("res://Scenes/Bullet.tscn")

onready var habilities := Events.player_habilities

onready var sprite := $Sprite
onready var animation_player := $AnimationPlayer
onready var collision_shape := $CollisionShape2D
onready var shoot_position := $Sprite/ShootPosition

func set_health(h):
	health = h
	emit_signal("health_changed", health)

func _ready():
	self.state = STATES.IDLE
	Events.connect("habilities_changed",self, "update_habilities")
	Events.connect("enemy_died",self, "fill_lantern")
	if lantern_max_time > 0:
		$LightFuel.start(lantern_max_time)
		
func fill_lantern():
	$LightFuel.start( lantern_max_time)
	
func update_habilities():
	habilities = Events.player_habilities
	
func set_state(new_state : int):
	# exit state
	match state:
		STATES.IDLE:
			pass
		STATES.WALK:
			pass
		STATES.ATTACK:
			pass
		STATES.DIE:
			pass
			
	state = new_state
	# enter state
	match state:
		STATES.IDLE:
			animation_player.current_animation = "Idle"
		STATES.WALK:
			animation_player.current_animation = "Walk"
		STATES.ATTACK:
			animation_player.current_animation = "Attack"
		STATES.DIE:
			animation_player.current_animation = "Death"
			emit_signal("dead")
		
func _physics_process(delta):
	var direction := Vector2.ZERO
	match state:
		STATES.IDLE:
			if _get_movement_direction().length() > 0:
				self.state = STATES.WALK
			if Input.is_action_pressed("Attack") and "Melee" in habilities:
				self.state = STATES.ATTACK
		STATES.WALK:
			direction = _get_movement_direction()
			if direction.length() == 0:
				self.state = STATES.IDLE
			
			if Input.is_action_pressed("Attack") and "Melee" in habilities:
				self.state = STATES.ATTACK
		STATES.ATTACK:
			
			if Input.is_action_just_released("Attack"):
				self.state = STATES.IDLE
			elif Input.is_action_just_pressed("Shoot") and not animation_player.is_playing() and "Shoot" in habilities:
				var bullet = bullet_scene.instance()
				bullet.direction = shoot_position.global_position.direction_to(MouseAim.get_target_position())
				get_parent().add_child(bullet)
				bullet.global_position = shoot_position.global_position
			
			var look_direction := get_global_mouse_position().x - global_position.x 
			if abs(look_direction) > 0:
				sprite.scale.x = sign(look_direction)
				collision_shape.scale.x = sign(look_direction)
				
		STATES.DIE:
			pass
			

	move_and_slide(direction * speed)

	if direction.x != 0:
		sprite.scale.x = sign(direction.x)
		collision_shape.scale.x = sign(direction.x)

func _get_movement_direction() -> Vector2:
	return  Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		Input.get_action_strength("Down") - Input.get_action_strength("Up")
	).normalized()

func melee():
	for enemy in $MeleeHitBox.get_overlapping_bodies():
		enemy.take_damage(2)

func take_damage(damage, source = null):
	if health <= 0: return
	self.health -= damage
	$EmphasisAnimator.play("Damage")
	$Camera2D.shake()
	if health <= 0:
		self.state = STATES.DIE


func _on_LightFuel_timeout():
	take_damage(INF)
