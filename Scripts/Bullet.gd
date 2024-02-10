extends Area2D

const SPEED = 400
var direction = Vector2.ZERO

# Preload the explosion scene
var explosionParticle = preload("res://Scenes/Effects/Explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#direction = get_viewport().get_mouse_position()
	#print(direction)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	explode()
	queue_free()

func _on_body_entered(body):
	explode()
	queue_free()
	
func _physics_process(delta):
	position += SPEED * delta * direction
	
func explode():
	var particle_instance = explosionParticle.instantiate()
	particle_instance.position = global_position
	particle_instance.one_shot = true
	particle_instance.emitting = true
	get_parent().add_child(particle_instance)
