extends Node

enum PlayerStates {THIN, FAT}
var playerState = PlayerStates.THIN

signal grow
signal shrink
signal activate_platform
signal deactivate_platform
