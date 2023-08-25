Here's a list of some of the most useful commands and shortcuts in `vi`:

### Mode Switching
- **`Esc`**: Switch to command mode.
- **`i`**: Switch to insert mode (before the cursor).
- **`a`**: Switch to insert mode (after the cursor).

### Navigation
- **`h`**: Move left.
- **`j`**: Move down.
- **`k`**: Move up.
- **`l`**: Move right.
- **`w`**: Move forward by a word.
- **`b`**: Move backward by a word.
- **`G`**: Go to the end of the file.
- **`gg`**: Go to the beginning of the file.
- **`:[line number]`**: Go to specific line number.

### Editing
- **`x`**: Delete the character under the cursor.
- **`dw`**: Delete the word under the cursor.
- **`dd`**: Delete the current line.
- **`u`**: Undo the last action.
- **`Ctrl + r`**: Redo the last undone action.
- **`yy`**: Yank (copy) the current line.
- **`p`**: Paste the yanked text.
- **`r`**: Replace the character under the cursor.
- **`:%s/old/new/g`**: Find and replace all occurrences of "old" with "new".

### File Operations
- **`:w`**: Save the file.
- **`:w [filename]`**: Save the file as `[filename]`.
- **`:q`**: Quit `vi` (only works if no changes have been made).
- **`:q!`**: Quit without saving changes.
- **`:wq`**: Save and quit.
- **`:e [filename]`**: Open `[filename]`.

### Miscellaneous
- **`/pattern`**: Search for a pattern in the text.
- **`n`**: Repeat the last search.
- **`:set number`**: Show line numbers.
- **`:set paste`**: Enable paste-friendly mode.

### Write to readonly files in VI:

`:w !sudo tee %`

What the command does:
* :w = Write a file.
* !sudo = Call shell sudo command.
* tee = The output of the vi/vim write command is redirected using tee.
* % = Triggers the use of the current filename.
* Simply put, the ‘tee’ command is run as sudo and follows the vi/vim command on the current filename given.


