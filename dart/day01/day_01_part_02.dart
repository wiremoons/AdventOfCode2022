#!/usr/bin/env -S dart
//
// @file day_01_part_02.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 01 Part 02.
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

// Get: 'test_input.txt' == false or 'puzzle_input.txt' == true
Future<String> getPuzzleFileInput(bool runTest) async {
  final inputFileName = runTest ? "test_input.txt" : "puzzle_input.txt";
  final inputFile = File('${Directory.current.path}/$inputFileName');

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

  int calTotal = 0;
  List<int> calList = [];

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  // loop through each set of elf's calories add each total to the list
  for (String calorie in lines) {
    if (calorie.isNotEmpty) {
      calTotal = calTotal + int.parse(calorie);
    } else {
      calList.add(calTotal);
      calTotal = 0;
    }
  }
  // add final read value from loop above
  calList.add(calTotal);
  // sort the list of calorie values
  calList.sort();
  // remove all calorie values except top three
  calList.removeRange(0, calList.length - 3);
  // sum up the remaining three highest calorie values
  int answer = calList.fold(0, (previous, current) => previous + current);

  // Test data answer:    45000
  // Puzzle data answer:  202346
  stdout.writeln("""

 >>  Advent of Code: Day 01 Part 2  <<
     -> Highest three max calorie totals are: '$answer'
""");
}
