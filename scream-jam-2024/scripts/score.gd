extends Node

var totalScore = 0
var levelScore = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func UpdateTotalScore(newValue: int):
	if newValue >= 0:
		totalScore = newValue

func UpdateLevelScore(newValue: int):
	if newValue >= 0:
		levelScore = newValue
	
func DecrementLevelScore(decrementValue: int):
	UpdateLevelScore(levelScore - decrementValue)

func getLevelScore():
	return levelScore

func getTotalScore():
	return totalScore
