#!/usr/bin/env -S dart
//
// @file day_05_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 05 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 05 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The program can be run with Dart language: https://dart.dev/
//
// Disable some specific linting rules in this file only
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:convert';

// local imports
import 'stack.dart';

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

// Extract the largest number stored at the end of the list
int getStackSize(List<String> inputStackList) {
  // strip out any unwanted contents from the inputStackList
  inputStackList.removeWhere((item) =>
      [" ", null, false, 0, int.tryParse(item) == null].contains(item));
  // extract the largest number stored in the last element of the inputStackList
  int numExtracted = int.parse(inputStackList.last);
  return numExtracted > 0 ? numExtracted : 0;
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
  final List<String> stackInput;
  final List<String> moveInput;
  final LineSplitter ls = LineSplitter();

  // get the top part of the input showing crate positions and stack numbers
  stackInput = ls.convert(input.split("\n\n").first);
  // get the lower part of the input showing the crate move instructions
  moveInput = ls.convert(input.split("\n\n").last);
  // get the number of crate stacks to work with
  int stacks = getStackSize(stackInput.last.split(""));
  // remove the stack numbers shown below the crate stack positions in the input
  stackInput.removeLast();

  // create stacks need to hold state of each set of crates (3 == test / 9 == puzzle)
  final s1 = Stack<String>();
  final s2 = Stack<String>();
  final s3 = Stack<String>();
  final s4 = Stack<String>();
  final s5 = Stack<String>();
  final s6 = Stack<String>();
  final s7 = Stack<String>();
  final s8 = Stack<String>();
  final s9 = Stack<String>();

  //stackInput.
  stdout.writeln("Stack Size: $stacks\n${stackInput}\n");

  // extra the starting crate stack positions from the input
  List<String> crates = [];
  List<List<String>> allCrates = [];
  int crateCount = 1;
  int columnCount = 0;

  for (String crateLine in stackInput) {
    for (int i = 1; i <= stacks; i++) {
      print("$crateCount -> ${crateLine[crateCount]}");
      crates.add(crateLine[crateCount]);
      crateCount = crateCount + 4;
    }
    print("->> $crates");
    allCrates.add(crates);
    crateCount = 1;
    columnCount <= stacks - 1 ? columnCount++ : columnCount = 0;
    //crates.clear();
  }

  stdout.writeln("STACKS:\n$allCrates");
  stdout.writeln("\nMove Input:\n${moveInput}");

  // Test data answer:    CMZ
  // Puzzle data answer:  TDCHVHJTG
  stdout.writeln("""

 >>  Advent of Code: Day 05 Part 1  <<
     -> The crates at the top of each stack is : '$answer'
""");
}
