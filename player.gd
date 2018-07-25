extends Area2D

const MOVEMENT_SPEED = 150.0
const MIN_LEFT_BORDER = 10
const MIN_TOP_BORDER = 10
const SCREEN_HEIGHT = 180 - MIN_TOP_BORDER
const SCREEN_WIDTH = 320 - MIN_LEFT_BORDER

signal destroyed

var can_shoot = true
var explosion_scene = preload("res://explosion.tscn")
var shot_scene = preload("res://shot.tscn")

func _process(delta):
    var input_dir = Vector2()
    if Input.is_key_pressed(KEY_UP):
        input_dir.y -= 1.0
    if Input.is_key_pressed(KEY_DOWN):
        input_dir.y += 1.0
    if Input.is_key_pressed(KEY_LEFT):
        input_dir.x -= 1.0
    if Input.is_key_pressed(KEY_RIGHT):
        input_dir.x += 1.0
        
    position += (delta * MOVEMENT_SPEED) * input_dir
    
    if position.x < MIN_LEFT_BORDER:
        position.x = MIN_LEFT_BORDER
    elif position.x > SCREEN_WIDTH:
        position.x = SCREEN_WIDTH
    if position.y < MIN_TOP_BORDER:
        position.y = MIN_TOP_BORDER
    elif position.y > SCREEN_HEIGHT:
        position.y = SCREEN_HEIGHT
        
    if Input.is_key_pressed(KEY_SPACE) and can_shoot:
        var stage_node = get_parent()
        var first_shot_instance = shot_scene.instance()
        var second_shot_instance = shot_scene.instance()
        first_shot_instance.position = position + Vector2(9, -5)
        second_shot_instance.position = position + Vector2(9, 5)
        stage_node.add_child(first_shot_instance)
        stage_node.add_child(second_shot_instance)
        can_shoot = false
        get_node("reload_timer").start()

func _on_reload_timer_timeout():
    can_shoot = true

func _on_player_area_entered(area):
    if area.is_in_group("asteroid"):
        queue_free()
        var stage_node = get_parent()
        var explosion_instance = explosion_scene.instance()
        explosion_instance.position = position
        stage_node.add_child(explosion_instance)
        emit_signal("destroyed")
        
