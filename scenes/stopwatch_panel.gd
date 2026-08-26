extends Panel

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var milliseconds: int = 0

@onready var flag = $"../../FlagArea"

@onready var returnButton = $"../Return"
@onready var restartButton = $"../Restart"

@onready var outcome = $"../Outcome"

func _process(delta) -> void:
	time += delta
	milliseconds = fmod(time, 1) * 100
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	$Minutes.text = "%02d:" % minutes
	$Seconds.text = "%02d:" % seconds
	$Milliseconds.text = "%03d" % milliseconds

func stop() -> void:
	set_process(false)



func _on_flag_area_body_entered(body: Node2D) -> void:
	stop()
	
	print(body.name)
	
	if body:
		#var bodySprite = body.get_parent()
		
		flag.get_node("CollisionShape2D").queue_free()
		
		if body:
			if body.name == "Speed":
				outcome.text = "You won!"
				outcome.show()
				
				$WinSound.play()
		
			if body.name == "Bot":
				outcome.text = "You lost!"
				outcome.show()
				
				$LossSound.play()
	
	returnButton.show()
	restartButton.show()
