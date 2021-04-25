extends KinematicBody2D

enum STATES {IDLE, WALK, ATTACK, DIE}
export var health := 3.0
var speed := 70
var direction := Vector2.RIGHT
var state : int = STATES.IDLE setget set_state
var safe_distance := 64-10
var in_range := false
var bullet_scene := preload("res://Scenes/ParabolicBullet.tscn")
export var should_move := false

var target = null

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
			$AnimationPlayer.current_animation = "Idle"
		STATES.WALK:
			$AnimationPlayer.current_animation = "Walk"
		STATES.ATTACK:
			$AnimationPlayer.current_animation = "Attack"
		STATES.DIE:
			$AnimationPlayer.play("Death")
			set_process(false)
			set_physics_process(false)

func _ready():
	safe_distance = $AttackArea/CollisionShape2D.shape.radius 

func _physics_process(_delta):
	match state:
		STATES.IDLE:
			if target != null:
				self.state = STATES.WALK
		STATES.WALK:
			if not should_move:
				continue
			var safe := global_position.distance_to(target.global_position) > safe_distance 
			if not safe:
				direction = target.global_position.direction_to(global_position).normalized()
			else:
				direction = global_position.direction_to(target.global_position).normalized()
			
			move_and_slide(speed*direction)
			if direction.x != 0:
				$Sprite.scale.x = sign(direction.x)
			
			if in_range and safe:
				self.state = STATES.ATTACK
		STATES.ATTACK:
			if not $AnimationPlayer.is_playing():
				self.state = STATES.IDLE
		STATES.DIE:
			pass

func _on_DetectionArea_body_entered(_body):
	if state == STATES.DIE:
		return
	target = _body
	$StateAnimation.play("Detected")

func _on_AttackArea_body_entered(_body):
	in_range = true
	
func shoot():
	var bullet = bullet_scene.instance()
	bullet.final_position = target.global_position
	bullet.initial_position = $Sprite/ShootPosition.global_position
	get_parent().add_child(bullet)
	bullet.global_position = bullet.initial_position
	


func _on_AttackArea_body_exited(_body):
	in_range = false


func _on_Area2D_area_entered(_area):
	if state == STATES.DIE: return
	$StateAnimation.play("MouseOver")


func _on_Area2D_area_exited(_area):
	if state == STATES.DIE : return
	$StateAnimation.play("MouseOut")

func take_damage(damage, _source = null):
	if health <= 0: return
	health -= damage
	$EmphasisAnimation.play("Damaged")
	if health <= 0:
		Events.emit_signal("enemy_died")
		global_position = global_position.snapped(Vector2.ONE)
		self.state = STATES.DIE
		$StateAnimation.play("MouseOut")
