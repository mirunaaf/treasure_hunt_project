#!/bin/bash

echo "\$\$\$\$\$\$\$\$\                                                                             \$\$\                             \$\$\      "     
 echo "\__\$\$  __|                                                                            \$\$ |                            \$\$ |     "    
 echo "   \$\$ |    \$\$\$\$\$\$\   \$\$\$\$\$\$\   \$\$\$\$\$\$\   \$\$\$\$\$\$\$\ \$\$\   \$\$\  \$\$\$\$\$\$\   \$\$\$\$\$\$\        \$\$\$\$\$\$\$\  \$\$\   \$\$\ \$\$\$\$\$\$\$\  \$\$\$\$\$\$\    "   
 echo "   \$\$ |   \$\$  __\$\$\ \$\$  __\$\$\  \____\$\$\ \$\$  _____|\$\$ |  \$\$ |\$\$  __\$\$\ \$\$  __\$\$\       \$\$  __\$\$\ \$\$ |  \$\$ |\$\$  __\$\$\ \_\$\$  _|   "  
 echo "   \$\$ |   \$\$ |  \__|\$\$\$\$\$\$\$\$ | \$\$\$\$\$\$\$ | \$\$\$\$\$\$\  \$\$ |  \$\$ |\$\$ |  \__|\$\$\$\$\$\$\$\$ |      \$\$ |  \$\$ |\$\$ |  \$\$ |\$\$ |  \$\$ |  \$\$ |     "    
 echo "   \$\$ |   \$\$ |      \$\$   ____|\$\$  __\$\$ | \____\$\$\ \$\$ |  \$\$ |\$\$ |      \$\$   ____|      \$\$ |  \$\$ |\$\$ |  \$\$ |\$\$ |  \$\$ |  \$\$ |\$\$\  " 
 echo "   \$\$ |   \$\$ |       \$\$\$\$\$\$\$\  \$\$\$\$\$\$\$ |\$\$\$\$\$\$\$  | \$\$\$\$\$\$  |\$\$ |       \$\$\$\$\$\$\$\       \$\$ |  \$\$ | \$\$\$\$\$\$  |\$\$ |  \$\$ |   \$\$\$\$  | "
 echo "   \__|   \__|       \_______| \_______|\_______/  \______/ \__|       \_______|      \__|  \__| \______/ \__|  \__|   \____/  "
 echo " "
 echo " "
 echo " "

# Welcome message

echo "🎉 Welcome to the Ultimate Treasure Hunt: Linux Edition! 🐧"
echo "Your mission: locate the treasure hidden somewhere in this grid."
echo "Think of it as 'find' meets 'grep' – with a twist! 🔍"
echo "Move with 'w/a/s/d', dig with 'dig', and test your luck."
echo "Hints? You’ve got 'h' for tips, but don’t expect man pages! 😉"
echo "Remember: You've got digging attempts – use them wisely!"
echo "Good luck, and may your terminal never freeze! 🚀"
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo ""

# Gets grid dimensions(rows,columns) from the user
while true; do
    read -p "Enter number of rows: " rows
    read -p "Enter number of columns: " cols
    if (( rows >= 3 && rows <= 15 && cols >= 3 && cols <= 15 )); then
        break
    fi
echo "For rows and columns please select 3-15."
done

# Player's starting position 
player_row=0
player_col=0

# Generates random treasure location
treasure_row=$((RANDOM % $rows))
treasure_col=$((RANDOM % $cols))

# Set digging attempts
attempts=$rows

# Initialize grid
grid=()
for ((i=0; i<rows; i++)); do
  for ((j=0; j<cols; j++)); do
    row+="*"
  done
  grid+=("$row")
done

# Function to print the grid
print_grid() {
  for ((i=0; i<rows; i++)); do
    for ((j=0; j<cols; j++)); do
      if [[ "${grid[$i]:$j:1}" == "T" ]]; then
        echo -n "T  "
      elif [[ $i -eq $player_row && $j -eq $player_col ]]; then
        echo -n "P  "
      else
        echo -n "${grid[$i]:$j:1}  "
      fi
    done
    echo
  done
}

expressionstooclose=("You're so close, even grep wouldn't need options to find it!" "very hot")
expressionsclose=("warmer" "maybe you're just a cd .. away")
expressionsfar=("cold" "very cold" "You're so far off, even ls can't find the treasure.")
 
 
hint_attempts=5
gen_hints() {
    if (( hint_attempts>0 )); then
        ((hint_attempts--))
        local row_diff=$(( player_row > treasure_row ? player_row - treasure_row : treasure_row - player_row ))
        local col_diff=$(( player_col > treasure_col ? player_col - treasure_col : treasure_col - player_col ))
        local distance=$(( row_diff + col_diff ))
        if (( distance <= 1 )); then
            selectexp=${expressionstooclose[$RANDOM % ${#expressionstooclose[@]}]}
                        echo $selectexp
        elif (( distance <= 2 )); then
            selectexp=${expressionsclose[$RANDOM % ${#expressionsclose[@]}]}
                echo $selectexp        
        else
            selectexp=${expressionsfar[$RANDOM % ${#expressionsfar[@]}]}
            echo $selectexp
        fi
        echo "you have $hint_attempts hint(s) remaining"
    else
        echo "You have used up all your hints!"
    fi
}

# Function to handle player movement
move_player() {

  case "$1" in
    "w") [[ $player_row -gt 0 ]] && ((player_row--)) ;;
    "s") [[ $player_row -lt $rows-1 ]] && ((player_row++)) ;;
    "a") [[ $player_col -gt 0 ]] && ((player_col--)) ;;
    "d") [[ $player_col -lt $cols-1 ]] && ((player_col++)) ;;
    *) echo "Invalid direction. Use 'w', 'a', 's', or 'd'." ;;
  esac
}

# Function to handle digging
dig() {
  local row=$player_row
  local col=$player_col

  # Checks if the cell already contains # (was previously dug)
  if [[ "${grid[$row]:$col:1}" == "#" ]]; then 
    echo "You've already dug here."

  # Checks if the player’s current position matches the treasure's location
  elif [[ $row -eq $treasure_row && $col -eq $treasure_col ]]; then
  # Inserts the character 'T' at the current column, marking the treasure's location
    grid[$row]="${grid[$row]:0:$col}"'T'${grid[$row]:$((col+1))}
    echo "You found the treasure! Congratulations!"
    print_grid
    exit 0

  # Replaces the * at the player's position with # (cell has been dug)
  else
    grid[$row]="${grid[$row]:0:$col}"'#'${grid[$row]:$((col+1))}
    echo "No treasure here."
    ((attempts--))
    if [[ $attempts -eq 0 ]]; then
      echo "You've used all your digging attempts. Game over."
      exit 0
    fi
  fi
}

# Main game loop
while true; do
  print_grid
  echo "----------------------------"
  echo "You have $attempts digging attempts left."
  echo ""
  read -p "Enter command (w/a/s/d to move,'h' for a hint, 'dig' to dig, 'quit' to exit): " command
  echo ""

  case "$command" in
    "w"|"a"|"s"|"d")
      move_player "$command"
      ;;
    "dig")
      dig
      ;;
    "h")
      gen_hints
      ;;
    "quit")
      echo "Thanks for playing!"
      echo "Score = $((hint_attempts * 10))"
      exit 0
      ;;
    *)
      echo "Invalid command. Use 'w', 'a', 's', 'd', 'dig', or 'quit'."
      ;;
  esac
done
