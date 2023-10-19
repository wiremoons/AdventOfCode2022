#!/usr/bin/env -S dart
//
// @file day_06_part_02.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 06 Part 02.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 06 Dec 2022
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

// Check if string has unique characters
bool isStringUnique(String input) {
  if (input.isEmpty) {
    return false;
  }
  for (var rune in input.runes) {
    var character = String.fromCharCode(rune);
    //print(character);
    if (character.allMatches(input).length > 1) {
      return false;
    }
  }
  return true;
}

// Detect the first time a fourth character marker occurs
int getCharacterMarkerPosition(String signal, int size) {
  if (signal.isEmpty) {
    return -1;
  }
  for (int count = 0; count < signal.length; count++) {
    if (isStringUnique(signal.substring(count, count + size))) {
      //print("${signal.substring(count, count + size)} at: ${count + size}");
      return count + size;
    }
  }
  return 0;
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

  for (String line in lines) {
    //stdout.write("Signal string: '${line}' is: ");
    answer = getCharacterMarkerPosition(line, 14);
    stdout.writeln("Start-of-message marker at: $answer");
  }

  // Test data answer:    19;23;23;29;26
  // Puzzle data answer:  3051
  stdout.writeln("""

 >>  Advent of Code: Day 06 Part 2  <<
     -> Characters processed before the start-of-message marker was detected : '$answer'
""");
}
