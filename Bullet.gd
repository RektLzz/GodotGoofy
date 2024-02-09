extends Area2D

const SPEED = 400
var direction = Vector2.ZERO
var boomEffect : CPUParticles2D
# Called when the node enters the scene tree for the first time.
func _ready():
	boomEffect = $Boom
	boomEffect.emitting = false
	#direction = get_viewport().get_mouse_position()
	#print(direction)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	boomEffect.emitting = true
	queue_free()

func _on_body_entered(body):
	if body.name != "CharacterBody2D":
		boomEffect.emitting = true
		queue_free()
	
func _physics_process(delta):
	position += SPEED * delta * direction
