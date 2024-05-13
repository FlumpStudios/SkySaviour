run_collision_checks
        jsr check_enemy_colliding_with_city
        jsr check_player_collided_with_bullet        
        jsr check_any_hit
        
        ; Don't check player bullet collided with enemy if bullet is not in play
        IF_NOT_EQUEL BULLET_IS_FIRING_LOCATION, #TRUE, @exit
        jsr check_bullet_collision     
@exit
        rts



;=========================================
;      CHECK ENEMIES COLLIDING WITH CITY
;=========================================
check_enemy_colliding_with_city
        IF_MORE_THAN ENEMY_1_Y_ADDRESS, #CITY_COLLISION_Y,@colliding_with_city
        IF_MORE_THAN ENEMY_2_Y_ADDRESS, #CITY_COLLISION_Y,@colliding_with_city
        IF_MORE_THAN ENEMY_3_Y_ADDRESS, #CITY_COLLISION_Y,@colliding_with_city
        IF_MORE_THAN ENEMY_4_Y_ADDRESS, #CITY_COLLISION_Y,@colliding_with_city
        rts
        
@colliding_with_city
        SET_PLAYER_TO_DEATH_STATE
        rts


;============================
;      PLAYER COLLISIONS
;============================
check_player_collided_with_bullet
        IF_ENEMY_BULLET_COLLIDED_WITH_PLAYER
        cpx #TRUE
        beq @kill_player
        rts

@kill_player
        SET_PLAYER_TO_DEATH_STATE
        rts


;============================
;      ENEMY COLLISIONS
;============================
check_bullet_collision
        lda #FALSE 
        sta TEMP3 ; user temp 3 to see if any collision took place

        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY1_HIT, ENEMY_1_X_ADDRESS, ENEMY_1_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_3_collision ; Skip variation change if not been hit

        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy1ToVar1
        lda #0        
        sta ENEMY_1_VARIATION
        jmp @check_enemy_3_collision

@setEnemy1ToVar1
        lda #1        
        sta ENEMY_1_VARIATION


@check_enemy_3_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY3_HIT, ENEMY_3_X_ADDRESS, ENEMY_3_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_4_collision ; Skip variation change if not been hit
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy3ToVar1
        lda #0        
        sta ENEMY_3_VARIATION
        jmp @check_enemy_4_collision

@setEnemy3ToVar1
        lda #1        
        sta ENEMY_3_VARIATION

@check_enemy_4_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY4_HIT, ENEMY_4_X_ADDRESS, ENEMY_4_CURRENT_FRAME_ADDRESS        

        cpx #TRUE ;Check if collision took place. Result should still be in the x register
        bne @check_enemy_2_collision ; Skip variation change if not been hit
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy4ToVar1
        lda #0        
        sta ENEMY_4_VARIATION
        jmp @check_enemy_2_collision

@setEnemy4ToVar1
        lda #1        
        sta ENEMY_4_VARIATION

@check_enemy_2_collision
        CHECK_IF_ENEMY_HAS_COLLIDED_WITH_BULLET ENEMY2_HIT, ENEMY_2_X_ADDRESS, ENEMY_2_CURRENT_FRAME_ADDRESS                
        cpx #TRUE
        bne @exit 
        
        lda #TRUE
        sta TEMP3

        jsr random ; Temp 1 and accumulator will store respose of the random function
        IF_LESS_THAN TEMP1, #145, @setEnemy2ToVar1
        lda #0        
        sta ENEMY_2_VARIATION
        jmp @exit

@exit
        rts

@setEnemy2ToVar1
        lda #1        
        sta ENEMY_2_VARIATION        

check_any_hit
        lda COLLISION_TAKEN_PLACE_ADDRESS 
        cmp #TRUE
        beq @update_display 
        jmp @exit
        
        
@update_display
        PRINT_DEBUG_16 #31,#12,SCORE_ADDRESS_HIGH, SCORE_ADDRESS_LOW
        PRINT_DEBUG #31,#15, CHAIN_ADDRESS  
        ldx #0 ; Reset the x register
        lda #FALSE
        sta COLLISION_TAKEN_PLACE_ADDRESS ; Reset temp 3 that we used to see if any collisions happened
        MAKE_EXPLOSION_SOUND
        IF_LESS_THAN SCORE_ADDRESS_HIGH, #3, @exit
        IF_LESS_THAN SCORE_ADDRESS_LOW, #232, @exit
        IF_EQUEL EXTRA_LIFE_AWARDED, #TRUE, @exit
        inc LIVES_ADDRESS
        lda #0 ; Little hack to generate a sound when extra life gained
        sta FIRE_SOUND_COUNTER
        lda #TRUE
        sta EXTRA_LIFE_AWARDED
        PRINT_DEBUG #33,#22, LIVES_ADDRESS
@exit
        rts



CHECK_PLAYER_BULLET_HIT_ENEMY  ; x register should contain the enemies x location and y reg the y location              
        stx TEMP3
        sty TEMP4

        ; Check if bullet is overlapping on the left
        lda BULLET_X_ADDRESS_LOW ; load bullet position
        adc #15 ; Takes you to the end of the bullet
        sta TEMP1

        ; temp less than x address        
        lda TEMP1
        cmp TEMP3
        bcc @has_not_collided

        ; Check if bullet is overlapping on the right
        sbc #6
        sta TEMP1
        lda TEMP3
        adc #24
        sta TEMP2
        
        ; If temp 1 is more than temp2         
        lda TEMP1
        cmp TEMP2
        bcs @has_not_collided
        
        ; Check if enemy has hit on the bottom of the enemy
        lda TEMP4
        adc #12
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2
        
        ; If temp 2 is more than temp 1         
        lda TEMP2
        cmp TEMP1
        bcs @has_not_collided

        lda TEMP4
        sbc #12
        
        sta TEMP1
        lda BULLET_Y_ADDRESS
        sta TEMP2
        
        lda TEMP2
        cmp TEMP1
        bcc @has_not_collided

; has collided
        lda #TRUE
        sta COLLISION_TAKEN_PLACE_ADDRESS
        jmp @done

@has_not_collided
        lda #FALSE
         
@done
        rts

