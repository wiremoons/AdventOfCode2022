#!/usr/bin/env -S dart
//
// @file day_04_part_02.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 04 Part 02.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 04 Dec 2022
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

/// Check if number 'x' is in the range of numbers 'low' and 'high'.
/// Uses 'num' for input variable so it work with 'int' or 'double'.
bool inRange(num low, num high, num x) {
  return ((x - high) * (x - low) <= 0);
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
  List<List<int>> secElf1 = [];
  List<List<int>> secElf2 = [];
  List<bool> secCheck = [];

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  for (String line in lines) {
    final List<String> sects = line.split(",");
    final List<String> e1sec = sects.first.split("-");
    final List<String> e2sec = sects.last.split("-");
    secElf1.add(e1sec.map((e) => int.parse(e)).toList());
    secElf2.add(e2sec.map((e) => int.parse(e)).toList());
    // stdout.writeln("${sects} -> ${e1sec} and ${e2sec}");
    // stdout.writeln(secElf1);
    // stdout.writeln(secElf2);
  }

  for (int count = 0; count <= secElf1.length - 1; count++) {
    // is elf one's range in any part of the range of elf two?
    secCheck.add(inRange(
            secElf2[count].first, secElf2[count].last, secElf1[count].first) ||
        inRange(
            secElf2[count].first, secElf2[count].last, secElf1[count].last));
    // is elf two's range in any of part of the range of elf one?
    secCheck.add(inRange(
            secElf1[count].first, secElf1[count].last, secElf2[count].first) ||
        inRange(
            secElf1[count].first, secElf1[count].last, secElf2[count].last));
    // count any overlapping areas
    ((secCheck.first) || (secCheck.last)) ? answer++ : answer;
    secCheck.clear();
  }

  // Test data answer:    4
  // Puzzle data answer:  815
  stdout.writeln("""

 >>  Advent of Code: Day 04 Part 2  <<
     -> The number of Elf pair assigned that the ranges overlap is : '$answer'
""");
}
