extends Label

var value: int = 1500
var maxValue: int = 1500

func _process(delta: float) -> void:
	self.text = str(value)
	
	if value + 2 <= maxValue:
		value += 2
		
	if value + 2 > maxValue:
		value = maxValue
