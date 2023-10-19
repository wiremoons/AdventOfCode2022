#!/usr/bin/env -S dart
//
// @file day_08_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 08 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 23 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The program can be run with Dart language: https://dart.dev/
//
// Disable some specific linting rules in this file only
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:convert';
import 'dart:math';

////////////////////////////////////////////////////////////////////////////////
// UTILITY HELPER FUNCTIONS
////////////////////////////////////////////////////////////////////////////////

/// Read either the test data file or puzzle data file and return as a String.
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

// get the width and height of the grid of numbers from the puzzle input
Point getGridSize(List<String> lines) {
  Point gridSize = Point(lines.length, lines.first.length);
  return gridSize;
}

////////////////////////////////////////////////////////////////////////////////
// ENTRY POINT FOR RUNNING PUZZLE SOLUTION FROM MAIN APPLICATION
////////////////////////////////////////////////////////////////////////////////
void main(List<String> arguments) async {
  bool runTest = false;
  (arguments.length == 1 && arguments[0] == "-t")
      ? runTest = true
      : runTest = false;

  final input = await getPuzzleFileInput(runTest);
  if (input.isEmpty) {
    stderr.writeln("ERROR: No file input available.");
    exit(1);
  }

  int answer = 0;
  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  Point gridSize = getGridSize(lines);
  stdout.writeln(gridSize);
  for (String line in lines) {
    stdout.writeln("${line}");
  }

  // Test data answer:   21
  // Puzzle data answer:
  stdout.writeln("""

 >>  Advent of Code: Day 08 Part 1  <<
     -> The number of trees visible are : '$answer'
""");
}
