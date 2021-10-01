extends Node2D

onready var fruits = get_node("Fruits")
var avocado = preload("res://Scenes//Avocado.tscn")
var orange = preload("res://Scenes//Orange.tscn")
var pear = preload("res://Scenes//Pear.tscn")
var pineapple = preload("res://Scenes//Pineapple.tscn")
var tomato = preload("res://Scenes//Tomato.tscn")
var watermelon = preload("res://Scenes//Watermelon.tscn")
var bomb = preload("res://Scenes//Bomb.tscn")

var score =0
var lifes = 3


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Generator_timeout():
	
	
	if lifes <= 0: return
	for i in range(0, rand_range(1,4)):
		var type = int(rand_range(0,8))
		var obj 
		if type == 0:
			obj = avocado.instance()
		elif type ==1:
			obj = bomb.instance()
		elif type ==2:
			obj = pear.instance()
		elif type ==3:
			obj = pineapple.instance()
		elif type ==4:
			obj = tomato.instance()
		elif type ==5:
			obj = watermelon.instance()
		elif type ==6:
			obj = bomb.instance()
		elif type ==7:
			obj = orange.instance()
		obj.born(Vector2(rand_range(300,1080),600))
		obj.connect("life",self,"dec_life")
		if type != 1 or type != 6:
			obj.connect("score",self,"inc_score")
			
		fruits.add_child(obj)

func dec_life():
	lifes -=1
	if lifes == 2:
		get_node("Control/Bomb1").set_modulate(Color(1,0,0))
		get_node("InputProc/SoundBomb").play()
	if lifes == 1:
		get_node("Control/Bomb2").set_modulate(Color(1,0,0))
		get_node("InputProc/SoundBomb").play()	
	if lifes == 0:
		get_node("GameOverScreen").start()
		get_node("InputProc").finish=true
		get_node("Control/Bomb3").set_modulate(Color(1,0,0))
		
		
func inc_score():
	if lifes ==0: return
	score +=1
	get_node("Control/Label").set_text(str(score))
