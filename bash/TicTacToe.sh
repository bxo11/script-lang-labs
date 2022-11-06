#!/bin/bash

BOARD=(- - - - - - - - -)
BAD_TURN=0
USER_MARKER="x"
END_REASON=""
CHANGES=0
INDEX=0

show_board() {
    local print_format=(${BOARD[6]} ${BOARD[7]} ${BOARD[8]}
        ${BOARD[3]} ${BOARD[4]} ${BOARD[5]}
        ${BOARD[0]} ${BOARD[1]} ${BOARD[2]})

    local i=0
    for item in "${print_format[@]}"; do
        printf $item

        if [ $i -eq 2 ]; then
            i=0
            echo ""
            continue
        fi
        i=$((i + 1))
    done
    echo ""
}

put_marker_at() {
    if ! [[ $1 =~ ^-?[0-9]+$ ]] || [ $1 -lt 1 ] || [ $1 -gt 9 ]; then
        BAD_TURN=1
        return
    fi

    local index=$1
    index=$((index - 1))

    if [ ${BOARD[$index]} != "-" ]; then
        BAD_TURN=1
        return
    fi

    local marker=$2
    BOARD[$index]=$marker
    CHANGES=$((CHANGES + 1))

    save_game
}

switch_user_mark() {
    if [ "$USER_MARKER" = "x" ]; then
        USER_MARKER="o"
    else
        USER_MARKER="x"
    fi
}

check_turn_amount() {
    if [ $CHANGES -ge 9 ]; then
        END_REASON="Draw"
        return
    fi
}

check_win_conditions() {
    local marker=$1$1$1
    local win_conditions=(${BOARD[0]}${BOARD[1]}${BOARD[2]} ${BOARD[3]}${BOARD[4]}${BOARD[5]} ${BOARD[6]}${BOARD[7]}${BOARD[8]} #rows
        ${BOARD[0]}${BOARD[3]}${BOARD[6]} ${BOARD[1]}${BOARD[4]}${BOARD[7]} ${BOARD[2]}${BOARD[5]}${BOARD[8]}                   #columns
        ${BOARD[0]}${BOARD[4]}${BOARD[8]} ${BOARD[2]}${BOARD[4]}${BOARD[6]})                                                    #cross

    for cond in "${win_conditions[@]}"; do
        if [ "$cond" = "$marker" ]; then
            END_REASON="User $1 won"
            return
        fi
    done
}

save_game() {
    printf "%s\n" "${BOARD[@]}" >save-TicTacToe.txt
}

load_game() {
    file="./save-TicTacToe.txt"
    lines=$(cat $file)
    local i=0
    local x_count=0
    local y_count=0
    for line in $lines; do
        BOARD[$i]=$line

        if [ "$line" = "x" ]; then
            x_count=$((x_count + 1))
        elif [ "$line" = "o" ]; then
            y_count=$((y_count + 1))
        fi

        i=$((i + 1))
    done

    CHANGES=$((x_count + y_count))
    check_turn_amount
    check_win_conditions "x"
    check_win_conditions "o"

    if [ $x_count -gt $y_count ]; then
        USER_MARKER="o"
    else
        USER_MARKER="x"
    fi
}

###
### MAIN
### start script with flag -c (play with computer) or -u (local multiplayer)
### add flag -l to load save from file ./save-TicTacToe.txt
###

if [ "$2" = "-l" ]; then
    load_game
fi

while [ 1 ]; do
    clear
    show_board

    # check if exist game should be closed
    if [ "$END_REASON" != "" ]; then
        echo $END_REASON
        break
    fi

    printf "user - %s: Put your marker at index: " $USER_MARKER

    case "$1" in
    "-c")
        if [ "$USER_MARKER" = "x" ]; then
            read INDEX
        else
            INDEX=$(((RANDOM % 9) + 1))
            echo ""
        fi
        ;;

    "-u")
        read INDEX
        echo ""
        ;;

    *)
        clear
        echo "Param not accepted"
        break
        ;;
    esac

    put_marker_at $INDEX $USER_MARKER
    check_turn_amount
    check_win_conditions $USER_MARKER

    # repeat turn if condition is true
    if [ $BAD_TURN -eq 1 ]; then
        BAD_TURN=0
    else
        switch_user_mark
    fi

done
