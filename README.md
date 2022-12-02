# AdventOfCode2022

Solutions for Advent of Code puzzles: https://adventofcode.com/2022

## About

Solutions to Advent of Code (AoC) 2022 using the [Dart](https://dart.dev/)
language. Not used Dart much before so using the puzzles as an opportunity to
try the language out.

## Solution Code

The source code for each day and part is linked below:

**Day 01**

Figuring out the Dart language to acheive what I wanted was the trickiest part,
but learnt a lot in the process.

- [Day 01 Part 01](./day01/day_01_part_01.dart)
- [Day 01 Part 02](./day01/day_01_part_02.dart)

**Day 02**

Solved it ok - but the code feels like a lot of compromises and very messy!
Progress with Dart is ok, but a bit frustrating still.

- [Day 02 Part 01](./day02/day_02_part_01.dart)
- [Day 02 Part 02](./day02/day_02_part_02.dart)

## Running the Code

The setup was originally created using the `dart create` command - but the work
involved to manage the puzzles code files and structure was over complicated.

After completing _Day 02_ I reorganised the code using a much simpler approach
of 'per day' directories. The code was then changed to run with a
[shebang](https://stackoverflow.com/a/22583962/13106309) using the Dart JIT. The
per day and part code files can also be built to use the AOT compiler if
preferred, to make a self-contained executable, but for the puzzles this is not
going to be needed. Nice to have the options though.

Currently each day and part code file should work using the following
instructions:

1. Download and install the [Dart SDK](https://dart.dev/get-dart);
2. Clone this GitHub repo to your computer:
   `git clone https://github.com/wiremoons/AdventOfCode2022.git`;
3. Change into the cloned repos directory and the puzzles daily directory you
   want to run;
4. Just run the `*.dart` script for each part (use: `chmod 755` first if
   needed).

Each code file can optionally be run with the additional parameter `-t` to make
it execute using the AOC test input, instead of the main puzzle input.

## License

All code is licenses with the [MIT License](./LICENSE). )
