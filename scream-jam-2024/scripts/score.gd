extends Node

var totalScore = 0
var levelScore = 0
var lives = 3
var isFirstTimeLoadingLevel = true

func SetLevelHasBeenLoaded():
	isFirstTimeLoadingLevel = false

func SetLevelHasBeenCompleted():
	isFirstTimeLoadingLevel = true

func UpdateTotalScore(newValue: int):
	if newValue >= 0:
		totalScore = newValue

func UpdateLevelScore(newValue: int):
	if newValue >= 0:
		levelScore = newValue
	
func DecrementLevelScore(decrementValue: int):
	UpdateLevelScore(levelScore - decrementValue)

func DecrementLives():
	lives -= 1

func getLevelScore():
	return levelScore

func getTotalScore():
	return totalScore
	
func getLives():
	return lives
