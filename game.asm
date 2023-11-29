section .data
    board db 3 dup (3 dup (' '))  ; 3x3 game board

    player_X db 'X'
    player_O db 'O'

    ; Messages
    msg_welcome db 'Welcome to Tic Tac Toe!', 0
    msg_enter_move db 'Enter your move (row and column): ', 0
    msg_invalid_move db 'Invalid move. Try again.', 0
    msg_winner db 'Congratulations! Player ', 0
    msg_draw db 'It\'s a draw!', 0
    msg_new_game db 'Do you want to play again? (Y/N): ', 0

section .text
    global _start

_start:
    ; Display welcome message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_welcome
    mov edx, 22
    int 0x80

game_loop:
    ; Initialize the board
    call initialize_board

    ; Main game loop
game_round:
    ; Display the current board
    call display_board

    ; Prompt the current player for a move
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_enter_move
    mov edx, 27
    int 0x80

    ; Read player's move
    mov eax, 3
    mov ebx, 0
    lea ecx, [board]
    mov edx, 9
    int 0x80

    ; Check for a winner or draw
    call check_winner
    test al, al
    jnz game_end

    ; Switch player
    call switch_player

    ; Repeat the round
    jmp game_round

game_end:
    ; Display game result
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_winner]
    mov edx, 26
    int 0x80

    ; Display the winning player
    mov eax, 4
    mov ebx, 1
    mov ecx, [board]
    mov edx, 1
    int 0x80

    ; Display draw message if no winner
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_draw]
    mov edx, 14
    int 0x80

    ; Ask for a new game
    mov eax, 4
    mov ebx, 1
    lea ecx, [msg_new_game]
    mov edx, 25
    int 0x80

    ; Read the player's choice
    mov eax, 3
    mov ebx, 0
    lea ecx, [board]
    mov edx, 1
    int 0x80

    ; Check if the player wants to play again
    cmp byte [board], 'Y'
    je game_loop

    ; Exit the program
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Function to initialize the game board
initialize_board:
    mov eax, 9
    mov edi, board
    mov ecx, 9
    rep stosb
    ret

; Function to display the game board
display_board:
    mov eax, 4
    mov ebx, 1
    mov ecx, [board]
    mov edx, 9
    int 0x80
    ret

; Function to switch player
switch_player:
    mov eax, [board]
    cmp eax, player_X
    je set_player_O

set_player_X:
    mov [board], player_X
    ret

set_player_O:
    mov [board], player_O
    ret

; Function to check for a winner or draw
check_winner:
    ; Implement the logic to check for a winner or draw
    ; Set zero flag if the game is still in progress
    ; Set non-zero flag if there's a winner or draw
    ; AL register can be used to store the result
    ret
