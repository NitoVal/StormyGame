class_name Player
extends CharacterBody3D

@export var camera: Camera3D
@export var animation_player: AnimationPlayer

const SPEED = 7.0
const DASH_SPEED: float = 20.0
const DASH_DURATION: float = 0.2
const DASH_COOLDOWN: float = 1.0

var _is_dashing: bool = false
var _dash_time_left: float = 0.0
var _dash_cooldown_time_left: float = 0.0
var _dash_direction: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
    # Add the gravity.
    if not is_on_floor():
        velocity += get_gravity() * delta
        
    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var input_dir := Input.get_vector("left", "right", "up", "down")
    var direction := Vector3(input_dir.x, 0, input_dir.y).normalized()
    if _dash_cooldown_time_left > 0:
        _dash_cooldown_time_left -= delta

    if Input.is_action_just_pressed("dash") and not _is_dashing and _dash_cooldown_time_left <= 0:
        _is_dashing = true
        _dash_time_left = DASH_DURATION
        _dash_cooldown_time_left = DASH_COOLDOWN
        _dash_direction = direction

    if _is_dashing:
        if _dash_time_left > 0:
            _dash_time_left -= delta
            velocity.x = _dash_direction.x * DASH_SPEED
            velocity.z = _dash_direction.z * DASH_SPEED
        else:
            _is_dashing = false
    else:
        if direction != Vector3.ZERO:
            velocity.x = direction.x * SPEED
            velocity.z = direction.z * SPEED
            _play_animation("PlayerLibrary/Running")
        else:
            velocity.x = move_toward(velocity.x, 0, SPEED)
            velocity.z = move_toward(velocity.z, 0, SPEED)
            _play_animation("PlayerLibrary/Idle")

    move_and_slide()
    var target_position: Vector3 = Vector3(position.x, 15.0, position.z + 7.5)
    camera.global_transform = Transform3D(camera.global_transform.basis, camera.global_transform.origin.lerp(target_position, 0.1))
    
func _play_animation(animation_name : String) -> void :
    if not animation_player.is_playing() or animation_player.current_animation != animation_name:
        animation_player.play(animation_name)
        
func _take_damage() -> void:
    print("ouch")
