        ;---------------------------------
        ;    Sprite and screen setup
        ;---------------------------------
run_menu_init        
        lda #$18
        sta $D018

        ; set sprite multicolors
        lda #$08
        sta $d025
        
        lda #$06
        sta $d026

        ; colorize sprites        
        ; Player ship
        lda #$01
        sta $d027

        ; ?
        lda #$05
        sta $d028

        ; Player bullet
        lda #$05
        sta $d029

        ; bee
        lda #ENEMY_COLOUR
        sta $d02A

        ; Spider
        lda #ENEMY_COLOUR
        sta $d02B

        ; enemy astroid/ant thing
        lda #ENEMY_COLOUR
        sta $d02C

        ; enemy bullet
        lda #ENEMY_BULLET_COLOUR
        sta $d02D

        ; enemy astroid/ant thing        
        lda #ENEMY_COLOUR
        sta $d02E



        ; positioning sprites        
        lda #125        ; Muncher
        sta ENEMY_2_X_ADDRESS       

        lda #215         ; Muncher
        sta ENEMY_2_Y_ADDRESS     


        ; X coordinate high bits
        lda #$00
        sta $d010

        
        ; set multicolor flags
        lda #%11111111
        sta $d01c

        ; set screen-sprite priority flags
        lda #$00
        sta $d01b

        lda #1
        sta ENEMY_1_VARIATION
        sta ENEMY_2_VARIATION        
        sta ENEMY_3_VARIATION
        sta ENEMY_4_VARIATION   
             

        ;================================
        ;     DRAW TITLE
        ;================================                
        lda #$D0
        sta $fb

        lda #$00
        sta $fd
        sta $f7


        lda #$2F
        sta $fc

        lda #$04
        sta $fe

        lda #$B8
        sta $f9
        lda #$33
        sta $fa

        lda #$d8
        sta $f8

        ldx #$00
        ldy #$00
        lda ($fb),y
        sta ($fd),y
        lda ($f9),y
        sta ($f7),y
        iny
        bne *-9

        inc $fc
        inc $fe
        inc $fa
        inc $f8

        inx
        cpx #$04
        bne *-24


        ; set screen-sprite priority flags
        lda #$00
        sta $d01b
        
        rts

run_game_initiation
        ;================================
        ;       DRAW THE PLAY AREA
        ;================================                
        lda #$0
        sta $fb
        sta $fd
        sta $f7

        lda #$28
        sta $fc

        lda #$04
        sta $fe

        lda #$e8
        sta $f9
        lda #$2b
        sta $fa

        lda #$d8
        sta $f8
        
        ldx #$00
        ldy #$00
        lda ($fb),y
        sta ($fd),y
        lda ($f9),y
        sta ($f7),y
        iny
        bne *-9

        inc $fc
        inc $fe
        inc $fa
        inc $f8

        inx
        cpx #$04
        bne *-24

        ;================================
        ;    INITIAL SPRITE LOCATION
        ;================================
        lda #145        ; Player_up_X
        sta $d000       
        lda #145        ; Player_up_Y
        sta $d001               
        lda #$91        ; Player_bullet_X
        sta $d004       
        lda #$0A        ; Player_bullet_Y
        sta $d005       
        
        

        RESET_DEATH_SOUND_PITCH
        

        lda #250
        sta ENEMY_1_Y_ADDRESS      
        sta ENEMY_2_Y_ADDRESS     
        sta ENEMY_3_Y_ADDRESS
        sta ENEMY_4_Y_ADDRESS
        sta ENEMY_BULLET_Y


        ;================================
        ;      SPRITE POINTERS
        ;================================
        lda #PLAYER_FRAME_1_VALUE
        sta PLAYER_ADDRESS
        
        ; Player_Bullet
        lda #PLAYER_BULLET_SPRITE_VALUE
        sta PLAYER_BULLET_SPRITE_ADDRESS

        lda #ENEMY_BULLET_SPRITE_VALUE
        sta ENEMY_BULLET_SPRITE_ADDRESS

        ; Enemy frames        
        lda #ROBOT_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_1_CURRENT_FRAME_ADDRESS       
        sta ENEMY_1_SPRITE_ADDRESS
        
        lda #ANDROID_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_3_CURRENT_FRAME_ADDRESS               
        sta ENEMY_3_SPRITE_ADDRESS

        sta ENEMY_4_CURRENT_FRAME_ADDRESS               
        sta ENEMY_4_SPRITE_ADDRESS       
        
        lda #MUNCHER_ENEMY_F1_SPRITE_VALUE
        sta ENEMY_2_CURRENT_FRAME_ADDRESS               
        sta ENEMY_2_SPRITE_ADDRESS

        ;================================
        ;       MEMORY INITIALISATION
        ;================================
        lda #0
        sta PLAYER_IN_DEATH_STATE        
        sta BULLET_IS_FIRING_LOCATION
        sta PLAYER_FLIPPED_LOCATION
        sta MUNCHER_1_HAS_BOUNCED_ADDRESS
        sta ENEMY_BULLET_IS_FIRING_ADDRESS
        sta ENEMY1_HIT
        sta ENEMY2_HIT
        sta ENEMY3_HIT
        sta ENEMY4_HIT
        sta TEMP1
        sta TEMP2
        sta TEMP3
        sta SCORE_ADDRESS_HIGH
        sta CHAIN_ADDRESS     
                       
        sta DEATH_TIMER_LOW
        sta ANIMATION_TIMER_ADDRESS
        sta GAMEPLAY_TIMER_ADDRESS
        sta BULLET_DIRECTION_LOCATION
        sta SCORE_ADDRESS_LOW   
        sta RECHARGE_TIMER
        sta IS_IN_END_OF_LEVEL
        sta END_OF_LEVEL_TIMER
        sta BACKGROUND_COLOUR_LOCATION
        sta ENEMY_1_X_ADDRESS       
        sta ENEMY_2_X_ADDRESS       
        sta ENEMY_3_X_ADDRESS
        sta ENEMY_4_X_ADDRESS
        sta ENEMY_BULLET_X
        sta EXPLOSION_COUNTER
        sta EXPLOSION_PITCH
        sta FIRE_SOUND_PITCH    
        sta EXTRA_LIFE_AWARDED
        sta FIRE_SOUND_COUNTER ; Nice side effect of setting this to zero is a nice lifting intro sounds
        
        lda #1
     
        
        sta MUNCHER_Y_SPEED_ADDRESS
        sta ROBOT_X_SPEED_ADDRESS 
        sta MUNCHER_X_SPEED_ADDRESS
        sta ASTROID_Y_SPEED_ADDRESS        
        sta ROBOT_Y_SPEED_ADDRESS
        sta ANDROID_X_SPEED_ADDRESS
        sta ANDROID_Y_SPEED_ADDRESS
        sta CURRENT_LEVEL


        sta ENEMIES_KILLED_LOW

        lda #2        
        sta ENEMY_BULLET_Y_SPEED_ADDRESS
        sta LIVES_ADDRESS

        lda #3
        sta UFO_X_SPEED_ADDRESS
        sta UFO_Y_SPEED_ADDRESS

        lda #75
        sta RANDOMISER_LOW

        lda #200
        sta RANDOMISER_HIGH

        TURN_ON_INITAL_SPRITES
        SET_TEXT_COLOUR #white
        jsr reset_all_enemies

        
        lda #MAX_BULLETS
        sta BULLETS_AVAILABLE

        ;================================
        ;       SETUP HUD TEXT
        ;================================       
        PRINT_DEBUG_16 #31,#12,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW 
        PRINT_DEBUG #33,#22,LIVES_ADDRESS         
        PRINT_DEBUG #31,#15, CHAIN_ADDRESS
        PRINT_DEBUG_16 #31,#7,HI_SCORE_ADDRESS_HIGH, HI_SCORE_ADDRESS_LOW
        