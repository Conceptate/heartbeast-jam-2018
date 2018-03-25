extends AnimatedSprite

# Initialize how long it takes for the sprite to switch frames
#const TIME_INTERVAL = 30
#
# Initialize animation cap and frames passed
#var animationCapped = true
#var framesPassed = 0
#
func _ready():
#	randomize()
#	set_process(true)
	pass
#
#func _process(delta):
#	if (framesPassed >= TIME_INTERVAL):
#		animationCapped = false
#		framesPassed = 0
#	
#	if (!animationCapped): # if animationCapped == false
#		animationCapped = true
#		
#		var prevFrame = self.get_frame()
#		var newFrame = randi() % self.get_sprite_frames().get_frame_count("default")
#		
#		while (newFrame == prevFrame):
#			newFrame = randi() % self.get_sprite_frames().get_frame_count("default")
#		
#		self.set_frame(newFrame)
#		print(randi() % self.get_sprite_frames().get_frame_count("default"))
#		print(self)
#	
#	framesPassed += 1 + delta
#	pass