#!/usr/bin/env -S dart
//
// @file day_10_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 10 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 11 Dec 2022
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
  int cpuReg = 1;
  int cycle = 0;
  int signal = cycle * cpuReg;

  // input 'addx V' takes two cycles to complete. After two cycles apply the X register
  // input 'noop'  takes one cycle to complete with no other effect

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  for (String line in lines) {
    print("$line");
  }

  // measure the: 20th, 60th, 100th, 140th, 180th, and 220th cycles
  // Test data answer:
  // Puzzle data answer: 1453349
  stdout.writeln("""

 >>  Advent of Code: Day 10 Part 1  <<
     -> The the sum of the six measured signal strengths is: '$answer'
""");
}
