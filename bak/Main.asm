; NOTES
; SCreen editor bh

; 10 SYS (4096)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $34, $30, $39, $36, $29, $00, $00, $00

*=$1000

Incasm "Memory.asm"
Incasm "Constants.asm"
Incasm "Macros.asm"

        ; Init Highscore
        lda #0
        sta HI_SCORE_ADDRESS_LOW
        sta HI_SCORE_ADDRESS_HIGH

main            
        jsr run_menu

initiate_game
        jsr run_game_initiation


; //////////////////
; //GAME PLAY LOOP//
; //////////////////
gameplay_loop     
        IF_NOT_EQUEL $d012, #$ff, gameplay_loop ; Raster line check

        inc GAMEPLAY_TIMER_ADDRESS
        IF_EQUEL PLAYER_IN_DEATH_STATE, #TRUE, @jmp_to_death
        
        jsr end_of_level        
        jsr handle_player_input
        jsr update_enemies
        jsr run_collision_checks  
        jsr run_sounds        
        jsr run_script
        jsr set_player_colour
        jsr update_bullet_UI
        jsr recharge_bullets
        jsr update_bullet_UI_colour
        
        ; If the gameplay timer is divisible by 10, flash the stars
        lda GAMEPLAY_TIMER_ADDRESS
        and #$0F        
        beq flash_stars
        jmp gameplay_loop

@jmp_to_death ; HACK: run_death sbr too far away
        jmp run_death

flash_stars
        lda ANIMATION_TIMER_ADDRESS ; Bit of a hack to use the anim timer to make the star bliking feel more random
        and #$01
        beq odd
        FLASH_STARS $0400
        FLASH_STARS $0400 + 510
        jmp gameplay_loop
odd
        FLASH_STARS $0400 + 255
        FLASH_STARS $0400 + 765        
        jmp gameplay_loop



; /////////////////////
; UPDATE PLAYERS COLOUR
; /////////////////////

set_player_colour
        IF_MORE_THAN PLAYER_Y_ADDRESS, #PLAYER_SHOT_LIMIT, @set_player_colour_to_not_shooting
        lda #0
        sta BORDER_COLOUR_LOCATION        
        lda BULLETS_AVAILABLE
        cmp #0
        beq @no_bullets        
        lda #$01
        sta $d027
        rts        

@set_player_colour_to_not_shooting
        IF_EQUEL BULLETS_AVAILABLE, #MAX_BULLETS, @exit
        inc BORDER_COLOUR_LOCATION
        jsr bank_chain
        lda #$06
        sta $d027
        rts
@exit
        lda #0
        sta BORDER_COLOUR_LOCATION        
        rts

@no_bullets
        inc $d027
        rts


update_bullet_UI
        ldx #0
        
@loop
        cpx BULLETS_AVAILABLE
        bcc @has_bullet

@no_bullet
        lda #UI_NO_BULLET
        jmp @do

@has_bullet
        lda #UI_HAS_BULLET

@do

        sta BULLET_UI_START_ADDRESS,x
        inx
        cpx #MAX_BULLETS
        bne @loop
        rts

update_bullet_UI_colour
        ldx #0
        IF_EQUEL BULLETS_AVAILABLE, #0, @nobullet
        IF_EQUEL BULLETS_AVAILABLE, #1, @one_bullet
        lda #YELLOW
        jmp @loop

@one_bullet
        lda #RED     
        jmp @loop

@nobullet
        lda COLOUR_RAM + 831
        adc #1        
@loop        
        sta COLOUR_RAM + 831 ,x
        inx
        cpx #MAX_BULLETS
        bne @loop
        rts
        


; ////////////////
; RECHARGE BULLETS
; ////////////////
recharge_bullets
        inc RECHARGE_TIMER
        IF_LESS_THAN RECHARGE_TIMER, #BULLET_RECHARGE_SPEED, @done
        lda #0
        sta RECHARGE_TIMER
        IF_MORE_THAN BULLETS_AVAILABLE, #MAX_BULLETS, @done
        IF_MORE_THAN PLAYER_Y_ADDRESS, #PLAYER_SHOT_LIMIT,@recharge   
        jmp @done


@recharge
        inc BULLETS_AVAILABLE      

@done
        rts

; ////////////
; END OF LEVEL
; ////////////

end_of_level
      
        IF_EQUEL IS_IN_END_OF_LEVEL, #FALSE, @finish         
        jsr reset_all_enemies
        jsr reset_enemy_bullet
        jsr @play_end_sound
        inc END_OF_LEVEL_TIMER;
        IF_MORE_THAN END_OF_LEVEL_TIMER,#END_OF_LEVEL_TIME, @turn_end_of_level_off    
        cmp #5
        bcc @flash_background
        jsr @draw_game_over
        jmp @finish
        
@turn_end_of_level_off
        jsr clear_game_over
        lda #0 
        sta END_OF_LEVEL_TIMER
        sta IS_IN_END_OF_LEVEL
        rts


@play_end_sound                
        lda #10 ; Little hack to generate a sound when extra life gained
        cmp END_OF_LEVEL_TIMER
        bne @finish
        sta FIRE_SOUND_COUNTER
        rts

@flash_background
        inc BACKGROUND_COLOUR_LOCATION

@finish
        rts

@draw_game_over
        SET_BACKGROUND_COLOUR #BLACK
        DRAW_CHAR #W, 449
        DRAW_CHAR #A, 450
        DRAW_CHAR #V, 451
        DRAW_CHAR #E, 452
        
        DRAW_CHAR #C, 454
        DRAW_CHAR #O, 455
        DRAW_CHAR #M, 456
        DRAW_CHAR #P, 457
        DRAW_CHAR #L, 458
        DRAW_CHAR #E, 459
        DRAW_CHAR #T, 460
        DRAW_CHAR #E, 461
        
        dec COLOUR_RAM + 449
        inc COLOUR_RAM + 450
        dec COLOUR_RAM + 451
        inc COLOUR_RAM + 452
        dec COLOUR_RAM + 454
        inc COLOUR_RAM + 455
        dec COLOUR_RAM + 456
        inc COLOUR_RAM + 457
        dec COLOUR_RAM + 458
        inc COLOUR_RAM + 459
        dec COLOUR_RAM + 460
        inc COLOUR_RAM + 461
@done
        rts

clear_game_over
        ldx #0
@loop
        lda #32;
        sta VRAM_START_ADDRESS + 449,x
        inx
        cpx #14
        bne @loop
        rts
        
        
Incasm "Audio.asm"
Incasm "Collisions.asm"
Incasm "Death.asm"
Incasm "Menu.asm"
Incasm "Utils.asm"
Incasm "GameScript.asm"
Incasm "Init.asm"
Incasm "Controls.asm"
Incasm "Enemies.asm"
Incasm "data.asm"
Incasm "Text.asm"