
handle_player_input        
        ; If bullet out of bounds enable bullet for shooting
        IF_LESS_THAN BULLET_Y_ADDRESS,#30,@set_bullet_as_not_firing
        jmp @handle_flip_shot

@set_bullet_as_not_firing                        
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 
        IF_NOT_EQUEL CHAIN_ADDRESS, #0, @reset_chain
        jmp @fire_direction_complete

@reset_chain
        jsr reset_chain

@handle_flip_shot
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #FALSE, @fire_direction_complete        
        lda BULLET_Y_ADDRESS      
        sbc #BULLET_MOVE_SPEED
        sta BULLET_Y_ADDRESS        

@fire_direction_complete

check_joystick_input
        jmp @input_left_check        

@input_left_check
        lda #$04
        bit $DC01
        bne @input_right_check 
        IF_LESS_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MIN_X, @input_right_check
        jsr @moveLeft

@input_right_check
        lda #$08
        bit $DC01               
        bne @input_up_check 

        IF_MORE_THAN PLAYER_X_ADDRESS_LOW, #PLAYER_MAX_X, @input_up_check
        jsr @moveRight                
  
@input_up_check
        lda #$01                
        bit $DC01               
        bne @input_down_check            
        
        IF_LESS_THAN PLAYER_Y_ADDRESS, #PLAYER_MIN_Y, @input_down_check
        jsr @moveUp
              
 
@input_down_check
        lda #$02               
        bit $DC01               
        bne @input_fire_check
        
        IF_MORE_THAN PLAYER_Y_ADDRESS, #PLAYER_MAX_Y, @input_fire_check
        
        jsr @moveDown                
  
@input_fire_check
        lda #$10                
        bit $DC01  
        bne @complete_joy_check                
        
        IF_MORE_THAN PLAYER_Y_ADDRESS, #PLAYER_SHOT_LIMIT, @complete_joy_check
        ;If bullet is already firing don't fire
        IF_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, @complete_joy_check
        IF_EQUEL IS_IN_END_OF_LEVEL, #TRUE, @complete_joy_check  
                
        
;After input checks
        IF_LESS_THAN BULLETS_AVAILABLE, #1, @complete_joy_check

        lda PLAYER_Y_ADDRESS        
        sta BULLET_Y_ADDRESS        

        ; Set the bullet x location to the player
        lda PLAYER_X_ADDRESS_LOW
        sta BULLET_X_ADDRESS_LOW

        lda PLAYER_FLIPPED_LOCATION
        sta BULLET_DIRECTION_LOCATION        
                
        lda #26
        sta FIRE_SOUND_COUNTER        
        
        lda #TRUE
        sta BULLET_IS_FIRING_LOCATION  
        

        dec BULLETS_AVAILABLE
        
    
@complete_joy_check
        rts

@moveUp
        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_Y_ADDRESS
        rts

@moveDown
        adc #PLAYER_MOVE_SPEED
        sta PLAYER_Y_ADDRESS
        rts

@moveLeft
        sbc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        rts

@moveRight
        adc #PLAYER_MOVE_SPEED
        sta PLAYER_X_ADDRESS_LOW
        rts
