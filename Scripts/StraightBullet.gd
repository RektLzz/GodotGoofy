extends Area2D

var direction : Vector2
var velocity : float
var damage : float
var lifetime : float
var target : String
var shooter

# Other shit
var collided

# Preload the trail scene
@export var TrailParticle : PackedScene

# Preload the explosion scene
@export var DeathParticle : PackedScene

func _on_lifetime_timeout():
	_bulletEffect(true, DeathParticle, global_position, true, true)

func _on_body_entered(body):
	if body != shooter:
		collided = true
		_bulletEffect(true, DeathParticle, global_position, true, true)
		
		if body.is_in_group(target) and body.has_method("take_damage"):
			body.take_damage(damage)
		
		#print("Bullet collided with: ", body, " Shooter: ", shooter)
	
func _physics_process(delta):
	position += velocity * delta * direction
	if not collided:
		_bulletEffect(false, TrailParticle, global_position, true, true)

# Play Effect
func _bulletEffect(destroy_bullet: bool, _particleEffect: PackedScene = null, effect_position: Vector2 = Vector2.ZERO, emitting: bool = true, one_shot: bool = true):
	# Check if a particle effect is provided
	if _particleEffect:
		var particles = _particleEffect.instantiate()
		particles.position = effect_position
		particles.emitting = emitting
		particles.one_shot = one_shot
		get_tree().current_scene.add_child(particles)
	
	# Destroy the bullet if required
	if destroy_bullet:
		queue_free()

func _spawn(pos, dir, vel, dmg, lft, trg, sht):
	position = pos
	direction = dir
	velocity = vel
	damage = dmg
	lifetime = lft
	target = trg
	shooter = sht
	_set_lifetime_timer()

	collided = false

func _set_lifetime_timer():
	$Lifetime.wait_time = lifetime
	$Lifetime.start()
