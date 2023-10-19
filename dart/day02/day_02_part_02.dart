#!/usr/bin/env -S dart
//
// @file day_02_part_02.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 02 Part 02.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 01 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The program can be run with Dart language: https://dart.dev/
//
// Disable some specific linting rules in this file only
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:convert';

////////////////////////////////////////////////////////////////////////////////
// UTILITY HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

Future<String> getPuzzleFileInput(bool runTest) async {
  final inputFileName = runTest ? "test_input.txt" : "puzzle_input.txt";
  final inputFile = File('${Directory.current.path}/$inputFileName');

  if (!await inputFile.exists()) {
    stderr.writeln("ERROR: not found file: ${inputFile}");
    return "";
  }

  try {
    var lines = await inputFile.readAsString();
    return lines;
  } catch (e) {
    stderr.writeln("ERROR: reading file: ${inputFile} as: '${e}'");
    return "";
  }
}

// convert the string value for players to a numeric equivalent one
// better handled with 'enum' and types but not figured it out for Dart!
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
  switch (p2) {
    case 1:
      {
        // need to loose
        if (p1 == 1) {
          return 3; // rock vs scissors
        } else if (p1 == 2) {
          return 1; // paper vs rock
        } else {
          return 2; // last loose option: paper
        }
      }
    case 2:
      {
        // need to draw
        if (p1 == 1) {
          return 1; // rock vs rock
        } else if (p1 == 2) {
          return 2; // paper vs paper
        } else {
          return 3; // last loose option: scissors
        }
      }
    case 3:
      {
        // need to win
        if (p1 == 1) {
          return 2; // rock vs paper
        } else if (p1 == 2) {
          return 3; // paper vs scissors
        } else {
          return 1; // last loose option: rock
        }
      }
    default:
      {
        print("ERROR: unknown shape for player two: '${p2}'");
        return 0;
      }
  }
}

// for player 2 (p2)
// X means you need to lose (1)
// Y means you need to end the round in a draw (2)
// Z means you need to win (3)
int getRequiredScore(int p2) {
  if (p2 == 1) {
    //stdout.write(" [p2 loose] ");
    return 0;
    // end draw
  } else if (p2 == 2) {
    //stdout.write(" [p2 draw] ");
    return 3;
  } else if (p2 == 3) {
    //stdout.write(" [p2 win] ");
    return 6;
  } else {
    //stdout.write(" >> BROKEN <<");
    return 0;
  }
}

////////////////////////////////////////////////////////////////////////////////
// ENTRY POINT FOR RUNNING PUZZLE SOLUTION FROM MAIN APPLICATION
////////////////////////////////////////////////////////////////////////////////
void main(List<String> arguments) async {
  bool runTest = false;
  (arguments.length == 1 && arguments[0] == "-t")
      ? runTest = true
      : runTest = false;

  final String input = await getPuzzleFileInput(runTest);
  if (input.isEmpty) {
    stderr.writeln("ERROR: No file input available.");
    exit(1);
  }
  //stdout.write(input);
//   stdout.writeln("""
// for player 2 (p2)
//  - X means you need to lose (pos: 1 | score: 0)
//  - Y means you need to end the round in a draw (pos: 2 | score: 3)
//  - Z means you need to win (pos: 3 | score: 6)
//  """);

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  int run_score = 0;

  for (String game in lines) {
    //stdout.writeln("Checking players shapes (running score: $run_score");
    final players = game.split(" ");
    int p1 = 0;
    int p2 = 0;
    //stdout.write("Player 1 : ${players.first} Player 2 : ${players.last} = ");

    p1 = getPlayerValue(players.first);
    p2 = getPlayerValue(players.last);

    int shapeScore = getRequiredScore(p2);
    int gameScore = getScore(p1, p2);

    run_score = run_score + gameScore + shapeScore;
    //stdout.writeln(" -> total : '$run_score' ($gameScore + $shapeScore = ${gameScore + shapeScore})");
  }
  // Test data answer:    12
  // Puzzle data answer:  12316
  stdout.writeln("""
 >>  Advent of Code: Day 02 Part 2  <<
     -> Rock Paper Scissors score is : '$run_score'
""");
}
