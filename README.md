# 🎉 Welcome to the Ultimate Treasure Hunt: Linux Edition! 🐧

Your mission: **Locate the treasure hidden somewhere in this grid!**  
Think of it as **'find' meets 'grep' – with a twist!** 🔍

- **Move with**: `w/a/s/d`
- **Dig with**: `dig`
- **Hints**: You’ve got `h` for tips, but don’t expect man pages! 😉
- **Remember**: You've got limited digging attempts – use them wisely!

Good luck, and may your terminal never freeze! 🚀  
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

---

## How to Execute the Code:

1. Open your terminal.
2. Navigate to the folder where the script is saved.
3. Make the script executable (if not already) by running:
   ```
   chmod +x treasure_hunt.sh
   ```
4. Run the game by typing:
   ```
   ./treasure_hunt.sh
   ```

## How to Play:

Enter Grid Size:

When prompted, input the number of rows and columns for the grid.
Grid size must be between 3 and 15 for both rows and columns.

## Move Around the Grid:

The player position is represented by a 'P' on the board.
Use these commands to navigate:

w: Move up
s: Move down
a: Move left
d: Move right

## Dig for Treasure:

Use the command:
dig
If you’re on the treasure’s location, you win! The treasure will be revealed, represnted by a 'T'.
If you didn’t find the treasure, a trail will be left, represented by a hash (#).

## Use a Hint:

Use the command:
h
This will give you a hint about how far you are from the treasure.
Note: Each time you use a hint, your score decreases. Use hints wisely!

## Quit the Game:

Use the command:
quit
Your final score will be displayed when you quit.

## How to Win:

Find and dig up the treasure before running out of digging attempts!

## Lose Case:

If you run out of digging attempts and haven’t found the treasure, the game ends, and you lose.
