# Jonathan Schwarz's Tic Tac Toe

## Game Modes

Jonathan Schwarz's Tic Tac Toe builds upon the Flatiron School's Tic Tac Toe lesson by adding on 4 game modes:

1. Easy
2. Medium
3. Hard
4. 2-Player

### Easy

Chooses an empty space at random

### Medium

Searches all lines within the WIN_COMBINATIONS constant, and selects any lines that have only one free space and two of the same character in the other spaces.  If no such space exists, medium chooses a space from any line that already has an X in it.

### Hard

Prioritizes the center space, followed by the corner spaces, if it meets the Medium search criteria.

### 2-Player

Allows for play between two humans, on the same computer.

## Play Again?

This version of Tic Tac Toe also adds a play again query at the end of each game.  yes, no, y, and n, are all acceptable answers, regardless of capitalization.