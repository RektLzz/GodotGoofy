extends CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.one_shot = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	timer.start()

# This method will be called when the timer times out
func _on_timer_timeout():
	# Queue this node to be freed
	queue_free()
