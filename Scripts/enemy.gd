class_name Enemy
extends RigidBody3D

var health: int = 1

# Called when the enemy takes damage
func _take_damage(damage: int) -> void:
    health -= damage
    if health <= 0:
        die()

# Handle enemy death
func die() -> void:
    queue_free()  # Remove the enemy from the scene

        
func _on_area_3d_area_entered(area: Area3D) -> void:
    if area.is_in_group("Player"):
        get_tree().call_group("Player", "_take_damage")
    else:
        print(area.name)
