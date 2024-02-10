extends CPUParticles2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Create a new Timer node
	var timer = Timer.new()
	# Set the timer to timeout after the lifetime of the CPUParticles2D
	timer.wait_time = lifetime
	# Make sure the timer does not repeat
	timer.one_shot = true
	# Add the timer as a child of this node
	add_child(timer)
	# Connect the timer's timeout signal to a method on this node using Callable
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	# Start the timer
	timer.start()

# This method will be called when the timer times out
func _on_timer_timeout():
	# Queue this node to be freed
	queue_free()
