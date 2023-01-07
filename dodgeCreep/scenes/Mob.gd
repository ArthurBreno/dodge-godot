extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true
	var tipo_de_mob = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = tipo_de_mob[randi() % tipo_de_mob.size()]
	
	pass # Replace with function body.
	



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
