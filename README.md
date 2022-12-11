# AdventOfCode2022

Solutions for Advent of Code puzzles: https://adventofcode.com/2022

## About

Solutions to Advent of Code (AoC) 2022 using the [Dart](https://dart.dev/)
language. Not used Dart much before so using the puzzles as an opportunity to
try the language out.

## Solution Code

The source code for each day and part is linked below:

**Day 01**

Figuring out the Dart language to achieve what I wanted was the trickiest part,
but learnt a lot in the process.

- [Day 01 Part 01](./day01/day_01_part_01.dart)
- [Day 01 Part 02](./day01/day_01_part_02.dart)

**Day 02**

Solved it ok - but the code feels like a lot of compromises and very messy!
Progress with Dart is ok, but a bit frustrating still.

- [Day 02 Part 01](./day02/day_02_part_01.dart)
- [Day 02 Part 02](./day02/day_02_part_02.dart)

**Day 03**

Felt more productive to today. While the puzzle was not completed any quicker,
the learning experience covering Dart lists, sets and character conversations
was all interesting, and good practical experience. Enjoyed the process, and the
outcome felt worthwhile.

- [Day 03 Part 01](./day03/day_03_part_01.dart)
- [Day 03 Part 02](./day03/day_03_part_02.dart)

**Day 04**

Enjoyable puzzle. Wasted a lot of time trying to write my code using a more
_functional style_ with `map` instead of more traditional `for loops`. Was
partially successful - but reverted to a `for` loop for the final logic tests
and count in the end. The 'Part 2' was a matter of swapping the `&&` for `||` on
the range checking - so easy once I understood the question. Also used
[Helix](https://helix-editor.com) text editor to code in, for most of the
session, which added some more challenging overhead to the experience.

- [Day 04 Part 01](./day04/day_04_part_01.dart)
- [Day 04 Part 02](./day04/day_04_part_02.dart)

**Day 05**

Today's puzzle was frustrating, but not due to the solutions complexity or
difficulty, but mainly from the perspective of parsing in the puzzle data. I was
unable to finished the puzzle on the day it came out, as I was back in work
today, so had less time, and the time I did have was spent fighting with Dart
(due to my lack of knowledge) trying to get the input ready. By the end of _Day
05_ I am getting there, but time to call it a day, and come back to it when I
have more time. Hoping _Day 06_ will be more achievable on a 'work day'.

- [Day 05 Part 01](./day05/day_05_part_01.dart) -> still _work in progress_
- [Day 05 Part 02](./day05/day_05_part_02.dart) -> still _work in progress_

**Day 06**

Managed to finish _Day 06_ before starting work today, which I am please about
after having the opposite experience yesterday. Hopefully can complete the _work
in progress_ puzzle _Day 05_ later... and catch back up.

- [Day 06 Part 01](./day06/day_06_part_01.dart)
- [Day 06 Part 02](./day06/day_06_part_02.dart)

**Day 07**

Started _Day 07_ the morning the puzzle came out - but was unable to complete it
due to other commitments. The solution was only one line of code away from
working - but I didnt realise it at the time when I stopped! So on _Day 11_ I
have the time to try to catch up on now, and have complete both parts. Was an
interesting puzzle, and I leant about using Dart `map` features.

- [Day 07 Part 01](./day07/day_07_part_01.dart)
- [Day 07 Part 02](./day07/day_07_part_02.dart)

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
