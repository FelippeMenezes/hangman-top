# Hangman - The Odin Project

This is a command-line implementation of the classic game Hangman, developed as part of The Odin Project's Ruby curriculum. The project focuses on object-oriented programming, file I/O, and data serialization.

## Features

### Game Logic
- **Word Selection**: The game automatically selects a random word from a dictionary file containing 10,000 English words. It filters for words between 5 and 12 characters to ensure a fair challenge.
- **Attempt Tracking**: Players have a maximum of 15 attempts to guess the secret word.
- **Input Validation**: The system ensures that only alphabetic characters are accepted. It also detects and notifies the player if a letter has already been guessed, preventing a loss of attempts for repeated inputs.
- **Visual Board**: A dynamic display shows correctly guessed letters in their positions, while maintaining underscores for hidden letters. It also lists all correct and incorrect letters used so far.

### Persistence
- **Save Game**: Players can save their current game state at any time during their turn. This includes the secret word, player name, remaining attempts, and all guessed letters.
- **Load Game**: The application can retrieve the last saved state from a YAML file, allowing players to resume their progress exactly where they left off.

### User Interface
- **Colorized Output**: Utilizes terminal colors to distinguish between correct guesses (green), incorrect guesses (red), and system prompts (blue/yellow), improving readability and user experience.
- **Menu System**: Simple numeric commands allow users to exit, save, or load games seamlessly during the game loop.

## Tools and Technologies

- **Ruby**: The core programming language used for logic and structure.
- **YAML**: Used for data serialization to handle saving and loading the game state in a human-readable format (`data_base.yaml`).
- **Colorize Gem**: A dependency used to enhance the command-line interface with various colors.
- **RuboCop**: Utilized as a linter and static code analyzer to ensure the code adheres to the Ruby Style Guide.
- **File I/O**: Ruby's built-in File class is used to read the dictionary and manage save files.

## Installation and Usage

1. Ensure you have Ruby installed on your system.
2. Clone this repository to your local machine.
3. Install the required dependencies using Bundler:
   ```bash
   bundle install
   ```
4. Run the game from the root directory:
   ```bash
   ruby main.rb
   ```

## Project Structure

- `main.rb`: The entry point of the application.
- `lib/match.rb`: Manages the game flow, including the main loop, saving, and loading.
- `lib/board.rb`: Handles the visual representation and letter validation logic.
- `lib/player.rb`: A simple class to store player information.
- `google-10000-english-no-swears.txt`: The dictionary source for secret words.
