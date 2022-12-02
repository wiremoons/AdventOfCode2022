//
// @file day_02_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 02 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 01 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The program can be run with Dart language: https://dart.dev/
import 'dart:io';
import 'dart:convert';

////////////////////////////////////////////////////////////////////////////////
// UTILITY HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

// Get: 'test_input.txt' == false or 'puzzle_input.txt' == true
Future<String> getPuzzleFileInput(bool test) async {
  final inputFileName = test ? "puzzle_input.txt" : "test_input.txt";
  final inputFile = File('${Directory.current.path}/lib/day02/$inputFileName');
  //stdout.writeln(inputFile);
  if (!await inputFile.exists()) {
    stderr.writeln("ERROR: not found file: ${inputFile}");
    return "";
  }
  //var length = await inputFile.length();
  //print(length);
  try {
    var lines = await inputFile.readAsString();
    return lines;
  } catch (e) {
    stderr.writeln("ERROR: reading file: ${inputFile} as: '${e}'");
    return "";
  }
}

int getPlayerValue(String shape) {
  int value = 0;
  switch (shape) {
    case "A":
    case "X":
      value = 1;
      break;
    case "B":
    case "Y":
      value = 2;
      break;
    case "C":
    case "Z":
      value = 3;
      break;
    default:
      print("ERROR: unknown shape for player one: '${shape}'");
      break;
  }
  return value;
}

int getShapeScore(String shape) {
  int value = 0;
  switch (shape) {
    case "X":
      value = 1;
      break;
    case "Y":
      value = 2;
      break;
    case "Z":
      value = 3;
      break;
    default:
      print("ERROR: unknown shape for player one: '${shape}'");
      break;
  }
  return value;
}

// values:
// ROCK = A or X  (1)
// PAPER = B or Y  (2)
// SCISSORS = C or Z  (3)
// Rules:
// Rock defeats Scissors
// Scissors defeats Paper
// Paper defeats Rock
//
int getScore(int p1, int p2) {
  if (p1 == p2) {
    //stdout.write("draw");
    return 3;
    // end draw
  } else if (p2 == 1 && p1 == 3) {
    //stdout.write("p2 win");
    return 6;
  } else if (p2 == 1 && p1 == 2) {
    //stdout.write("p2 loose");
    return 0;
    // end p2 ROCK
  } else if (p2 == 2 && p1 == 1) {
    //stdout.write("p2 win");
    return 6;
  } else if (p2 == 2 && p1 == 3) {
    //stdout.write("p2 loose");
    return 0;
    // end PAPER
  } else if (p2 == 3 && p1 == 1) {
    //stdout.write("p2 loose");
    return 0;
  } else if (p2 == 3 && p1 == 2) {
    //stdout.write("p2 wins");
    return 6;
    // end SCISSORS
  } else {
    //stdout.write("BROKEN");
    return 0;
  }
}

////////////////////////////////////////////////////////////////////////////////
// ENTRY POINT FOR RUNNING PUZZLE SOLUTION FROM MAIN APPLICATION
////////////////////////////////////////////////////////////////////////////////
void day_02_part_01() async {
  bool puzzle = true;
  //int answer = 0;
  int run_score = 0;

  final String input = await getPuzzleFileInput(puzzle);
  if (input.isEmpty) {
    stderr.writeln("ERROR: No file input available.");
    exit(1);
  }
  //stdout.write(input);

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);
  lines.forEach((game) {
    //stdout.writeln("Checking players shapes (running score: $run_score");
    final players = game.split(" ");
    int p1 = 0;
    int p2 = 0;
    //stdout.write("Player 1 : ${players.first} Player 2 : ${players.last} = ");

    p1 = getPlayerValue(players.first);
    p2 = getPlayerValue(players.last);
    int game_score = getScore(p1, p2);
    int shape_score = getShapeScore(players.last);
    run_score = run_score + game_score + shape_score;
    //stdout.writeln(" -> total : '$run_score' ($game_score + $shape_score = ${game_score + shape_score})");
  });
  // Test data answer:    15
  // Puzzle data answer: 13809
  stdout.writeln("""
 >>  Advent of Code: Day 02 Part 1  <<
     -> Rock Paper Scissors score is : '$run_score'
     """);
}
