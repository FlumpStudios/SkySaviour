run_menu
        TURN_OFF_ALL_SPRITES
        SET_TEXT_COLOUR #white
        CLEAR_KEYBOARD_BUFFER
        CLEAR_SCREEN
        jsr reset_background_border_colour
        jsr run_menu_init

main_menu_loop
        ; TODO: Switch out with interupt
        IF_NOT_EQUEL $d012, #$ff, main_menu_loop ; Raster line check       

@skip_no_frame
        IF_NOT_EQUEL ANIMATION_TIMER_ADDRESS, #1, @draw_menu
        inc $0286 
        lda $0286
        cmp #Black
      
        
@draw_menu          

        lda GAMEPLAY_TIMER_ADDRESS
        adc #6
        sta GAMEPLAY_TIMER_ADDRESS
        
        IF_EQUEL GAMEPLAY_TIMER_ADDRESS, #128, update_colour
        IF_LESS_THAN GAMEPLAY_TIMER_ADDRESS, #127, print_key_press
        IF_MORE_THAN GAMEPLAY_TIMER_ADDRESS, #127, clear_print_press

loop_menu       
        jmp main_menu_loop

flash_loop
        lda $c6
        beq loop_menu        
        jmp initiate_game ;load the game if a key is pressed

print_key_press
        PRINT press_to_continue,  VRAM_START_ADDRESS + 647
        jmp flash_loop

clear_print_press
        PRINT clear, VRAM_START_ADDRESS + 647
        jmp flash_loop

update_colour
        jmp flash_loop