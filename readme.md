## Knight Travails Algorithm

My implementation of Knight Travails problem from [Odin's Ruby Course](https://www.theodinproject.com/lessons/ruby-knights-travails).

## Scaffolding

The project uses `nix`. Install it and run `nix develop` from the project folder.

Run `rspec spec/board_spec.rb` to test and `ruby main` to run simple driver script.

## Implementation

`#knight_moves(start, target)` is implemented this way:

- Start with the starting position, e.g. `[0, 0]`.
- Calculate all possible knight moves from `[0, 0]` using `#possible_moves`.
- For each move:
  - If it hasn’t been visited, add it to the visited set.
  - Create a new path by appending the move to the current path and add that to the queue.
- Then, for each path in the queue:
- Take the last position in the path (`path.last`).
- If it’s the target, stop and return the path.
- Otherwise, repeat the process:
  - Get all possible moves from `path.last`.
  - Skip already visited moves.
  - For each valid new move, append it to the path and push it to the queue.
- This loop continues until the target is reached.

It's easier seen in code then explained.
