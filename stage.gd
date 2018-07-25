extends Node2D

const SCREEN_HEIGHT = 180
const SCREEN_WIDTH = 320

var asteroid_scene = preload("res://asteroid.tscn")
var is_game_over = false
var score = 0

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        get_tree().quit()
    if is_game_over and Input.is_key_pressed(KEY_ENTER):
        get_tree().change_scene("res://stage.tscn")

func _ready():
    get_node("player").connect("destroyed", self, "_on_player_destroyed")
    $spawn_timer.connect("timeout", self, "_on_spawn_timer_timeout")
    
func _on_player_destroyed():
    get_node("ui/retry").show()
    is_game_over = true
    
func _on_player_score():
    score += 1
    get_node("ui/score").text = "Score: " + str(score)
    
func _on_spawn_timer_timeout():
    var asteroid_instance = asteroid_scene.instance()
    asteroid_instance.movement_speed += score
    asteroid_instance.position = Vector2(SCREEN_WIDTH + 8, rand_range(10, SCREEN_HEIGHT - 10))
    asteroid_instance.connect("score", self, "_on_player_score")
    add_child(asteroid_instance)
    $spawn_timer.wait_time *= 0.99