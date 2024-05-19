run_script

;1: Enemy
;2: Free
;3: Player Bullet
;4: Enemy 1
;5: Enemy 2
;6: Enemy 3
;7: Enemy Bullet
;8: Enemy 4

@level1    
        IF_MORE_THAN ENEMIES_KILLED_LOW, #10, @level2
        
        ldx #1
        stx ENEMY_4_VARIATION
        lda #%10000111
        sta SPRITE_ENABLED_ADDRESS
        jmp @done
@exit
        rts

@level2
        IF_MORE_THAN ENEMIES_KILLED_LOW, #22, @level3

        lda CURRENT_LEVEL
        cmp #2
        beq @run_level2
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL



@run_level2
        lda #%10100111 
        sta SPRITE_ENABLED_ADDRESS

        ldx #1
        stx ENEMY_4_VARIATION ; Force enemy 1 to astroid variation
        stx ENEMY_3_VARIATION

        jmp @done

@level3
        IF_MORE_THAN ENEMIES_KILLED_LOW, #36, @level4

        lda CURRENT_LEVEL
        cmp #3
        beq @run_level3
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL


@run_level3
        lda #%01101111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        ldx #1
        stx ENEMY_3_VARIATION      
        stx ENEMY_1_VARIATION
        jmp @done


@level4
        IF_MORE_THAN ENEMIES_KILLED_LOW, #52, @level5
        lda CURRENT_LEVEL
        cmp #4
        beq @run_level4
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL
        

@run_level4
        lda #%11101111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        ldx #1
        stx ENEMY_4_VARIATION 
        stx ENEMY_3_VARIATION
        stx ENEMY_2_VARIATION
        stx ENEMY_1_VARIATION
        jmp @done

@level5
        IF_MORE_THAN ENEMIES_KILLED_LOW, #70, @level6
        lda CURRENT_LEVEL
        cmp #5
        beq @run_level5
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL

@run_level5
        lda #%01101111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        ldx #0
        stx ENEMY_2_VARIATION
        stx ENEMY_1_VARIATION
        jmp @done


@level6
        IF_MORE_THAN ENEMIES_KILLED_LOW, #90, @level7
        lda CURRENT_LEVEL
        cmp #6
        beq @run_level6
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL


@run_level6
        lda #%11101111
        sta SPRITE_ENABLED_ADDRESS

        ldx #1
        stx ENEMY_1_VARIATION ; Force enemy 1 to robot variation

        jmp @done

@level7
        IF_MORE_THAN ENEMIES_KILLED_LOW, #112, @level8
        lda CURRENT_LEVEL
        cmp #7
        beq @run_level7
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL


@run_level7
        lda #%11110111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        
        ldx #0
        stx ENEMY_2_VARIATION ; Force enemy 2 to UFO variation

        jmp @done

@level8
        IF_MORE_THAN ENEMIES_KILLED_LOW, #136, @level9
        lda CURRENT_LEVEL
        cmp #8
        beq @run_level8
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL

@run_level8
        lda #%01111111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS
        jmp @done

@level9
        IF_MORE_THAN ENEMIES_KILLED_LOW, #150, @reset
        
        lda CURRENT_LEVEL
        cmp #9
        beq @run_level9
        
        lda #TRUE
        sta IS_IN_END_OF_LEVEL
        
        inc CURRENT_LEVEL

@run_level9
        lda #%11111111 ;Turn enemy 4 off and 1 and bullet on
        sta SPRITE_ENABLED_ADDRESS       

@reset
        lda #8
        sta CURRENT_LEVEL
        lda #137
        sta ENEMIES_KILLED_LOW

@done
        rts


is_off_screen ;(y reg = sprite y position)
        sty TEMP1
        IF_LESS_THAN TEMP1, #40, @true 
        IF_MORE_THAN TEMP1, #240, @true
        ldx #FALSE
        rts

@true
        ldx #TRUE
        rts