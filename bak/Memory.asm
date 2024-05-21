;========================
;     MEMORY RANGES
;========================
VRAM_START_ADDRESS = $0400
VRAM_END_ADDRESS = $0800
COLOUR_RAM = $D800 
;===================
;     HIGH MEM
;===================
MENU_FLASH = $C01A

SCORE_ADDRESS_LOW  =  $C000
SCORE_ADDRESS_HIGH  =  $C001
LIVES_ADDRESS  =  $C002
CHAIN_ADDRESS  =  $C004
DEATH_TIMER_LOW = $C006
ENEMY1_HIT = $C008
ENEMY2_HIT = $C00A
ENEMY3_HIT = $C00C
HI_SCORE_ADDRESS_HIGH = $C00E
HI_SCORE_ADDRESS_LOW = $C010

ENEMY_1_VARIATION = $C012
ENEMY_2_VARIATION = $C014
ENEMY_3_VARIATION = $C016
PLAYER_IN_DEATH_STATE = $C018

MUNCHER_1_HAS_BOUNCED_ADDRESS =  $C01C
MUNCHER_X_SPEED_ADDRESS =  $C01E
MUNCHER_Y_SPEED_ADDRESS =  $C020

ASTROID_Y_SPEED_ADDRESS =  $C022

ROBOT_X_SPEED_ADDRESS =  $C024
ROBOT_Y_SPEED_ADDRESS =  $C026

ENEMIES_KILLED_LOW =  $C028


UFO_X_SPEED_ADDRESS =  $C02A
UFO_Y_SPEED_ADDRESS =  $C02C

RANDOMISER_LOW = $C02E
RANDOMISER_HIGH = $C02F


ENEMY_BULLET_Y_SPEED_ADDRESS =  $C033

ANDROID_X_SPEED_ADDRESS =  $C035
ANDROID_Y_SPEED_ADDRESS =  $C037

ENEMY_4_VARIATION = $C039
ENEMY4_HIT = $C03B

EXPLOSION_COUNTER = $C03D
EXPLOSION_PITCH = $C03E

DEATH_SOUND_PITCH = $C04A
FIRE_SOUND_COUNTER = $C04C
FIRE_SOUND_PITCH = $C04D
EXTRA_LIFE_AWARDED = $C04E

BULLETS_AVAILABLE = $C04F
RECHARGE_TIMER = $C050

IS_IN_END_OF_LEVEL = $C051
END_OF_LEVEL_TIMER = $C052

CURRENT_LEVEL = $C053

LEVEL_END_PITCH = $C054



;===================
;     ZERO PAGE #73-7b
;===================
PLAYER_FLIPPED_LOCATION = $02
TEMP1 = $73
TEMP2 = $74
TEMP3 = $75
TEMP4 = $7D

ANIMATION_TIMER_ADDRESS = $76
GAMEPLAY_TIMER_ADDRESS = $77
BULLET_IS_FIRING_LOCATION = $78
BULLET_DIRECTION_LOCATION = $79
ENEMY_BULLET_IS_FIRING_ADDRESS = $7A
ENEMY_X_ADDRESS_COLLISION_PARAM = $7B
ENEMY_FRAME_COLLISION_PARAM = $7C

COLLISION_TAKEN_PLACE_ADDRESS = $7E
ENEMY_HIT_COLLISION_PARAM = $7F


;=============
;   MAPPED
;=============
BORDER_COLOUR_LOCATION = $d020
BACKGROUND_COLOUR_LOCATION = $d021
SPRITE_ENABLED_ADDRESS = $d015

BULLET_UI_START_ADDRESS = $073F


;===============
;    SPRITES
;===============
; SPRITE POINTERS
PLAYER_FRAME_1_VALUE = $28
PLAYER_FRAME_2_VALUE = $29
PLAYER_BULLET_SPRITE_VALUE = $2A
ENEMY_BULLET_SPRITE_VALUE = $38

;Sprite addresses
PLAYER_ADDRESS = $07F8
PLAYER_BULLET_SPRITE_ADDRESS = $07FA

ENEMY_1_SPRITE_ADDRESS = $07FB
ENEMY_2_SPRITE_ADDRESS = $07FC
ENEMY_3_SPRITE_ADDRESS = $07FD
ENEMY_BULLET_SPRITE_ADDRESS = $07FE
ENEMY_4_SPRITE_ADDRESS = $07FF

;Sprite positions
PLAYER_X_ADDRESS_LOW = $d000 
PLAYER_Y_ADDRESS = $d001

BULLET_X_ADDRESS_LOW = $d004 
BULLET_Y_ADDRESS = $d005

ENEMY_1_X_ADDRESS = $d006 
ENEMY_1_Y_ADDRESS = $d007

ENEMY_2_X_ADDRESS = $d008
ENEMY_2_Y_ADDRESS = $d009

ENEMY_3_X_ADDRESS = $d00A
ENEMY_3_Y_ADDRESS = $d00B

ENEMY_BULLET_X = $d00C
ENEMY_BULLET_Y = $d00D

ENEMY_4_X_ADDRESS = $d00E
ENEMY_4_Y_ADDRESS = $d00F


; Sprite animation frame data
ROBOT_ENEMY_F1_SPRITE_VALUE = $2b
ROBOT_ENEMY_RESET_FRAME = $2d

EXPLOSION_F1_SPRITE_VALUE = $2f
EXPLOSION_RESET_FRAME = $32

MUNCHER_ENEMY_F1_SPRITE_VALUE = $32 
MUNCHER_ENEMY_RESET_FRAME = $35

ASTROID_ENEMY_F1_SPRITE_VALUE = $36
ASTROID_ENEMY_RESET_FRAME = $38

UFO_ENEMY_F1_SPRITE_VALUE = $39
UFO_ENEMY_RESET_FRAME = $3B

ANDROID_ENEMY_F1_SPRITE_VALUE = $3B
ANDROID_ENEMY_RESET_FRAME = $3E

; Sprite current frame pointers
ENEMY_1_CURRENT_FRAME_ADDRESS = ENEMY_1_SPRITE_ADDRESS
ENEMY_2_CURRENT_FRAME_ADDRESS = ENEMY_2_SPRITE_ADDRESS
ENEMY_3_CURRENT_FRAME_ADDRESS = ENEMY_3_SPRITE_ADDRESS
ENEMY_4_CURRENT_FRAME_ADDRESS = ENEMY_4_SPRITE_ADDRESS