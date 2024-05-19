reset_background_border_colour
        ; set border color
        lda #BLACK
        sta $D020
        
        ; set background color
        lda #BLACK
        sta $D021
        rts

random
        lda #$FF  ; maximum frequency value
        sta $D40E ; voice 3 frequency low byte
        sta $D40F ; voice 3 frequency high byte
        lda #$80  ; noise waveform, gate bit off
        sta $D412 ; voice 3 control register
        lda $D41B
        sta TEMP1 
        IF_LESS_THAN TEMP1, RANDOMISER_LOW, random
        IF_MORE_THAN TEMP1, RANDOMISER_HIGH, random
        rts

handle_enemy_hit_by_bullet 
        clc
        inc ENEMIES_KILLED_LOW
        
        lda #FALSE
        sta BULLET_IS_FIRING_LOCATION 

        ; Move the bullet off screen so the reset code can run
        ; Don't move it past 250, otherwise the chain will reset
        lda #249
        sta BULLET_Y_ADDRESS        
        rts


bank_chain
        clc
        lda SCORE_ADDRESS_LOW 
        adc CHAIN_ADDRESS        
        sta SCORE_ADDRESS_LOW
        lda SCORE_ADDRESS_HIGH
        adc #$00
        sta SCORE_ADDRESS_HIGH  
        lda #TRUE
        sta COLLISION_TAKEN_PLACE_ADDRESS
        IF_MORE_THAN CHAIN_ADDRESS, #1, reset_chain
        jsr reset_chain
        rts

reset_chain
        DRAW_CHAR #ClearBlock, 632
        lda #0
        sta CHAIN_ADDRESS
        rts

add_to_score
        clc
        lda SCORE_ADDRESS_LOW 
        ;adc CHAIN_ADDRESS        
        adc BULLETS_AVAILABLE
        adc #1
        sta SCORE_ADDRESS_LOW
        lda SCORE_ADDRESS_HIGH
        adc #$00
        sta SCORE_ADDRESS_HIGH  
        rts
        
inc_chain        
        lda BULLETS_AVAILABLE
        cmp #0
        beq @done

        lda CHAIN_ADDRESS
        cmp #MAX_CHAIN
        beq @done
        lda CHAIN_ADDRESS
        adc #CHAIN_INCREASE_AMOUNT
        sta CHAIN_ADDRESS
@done        
        rts
        
        