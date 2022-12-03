#!/usr/bin/env -S dart
//
// @file day_03_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 03 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 03 Dec 2022
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

/// Compare the two compartments of the ruck sack to identify the common
/// duplicate item. Use Sets to manage unique items. Create the Sets by converting
/// the ASCII compartment strings to equivalent decimal values.
/// The 'intersection' function identifies the common values.
Set<int> getIntersection(String compart1, String compart2) {
  Set<int> compart1Unit = Set<int>.from(compart1.codeUnits);
  Set<int> compart2Unit = Set<int>.from(compart2.codeUnits);
  final Set<int> interSec = compart1Unit.intersection(compart2Unit);
  //stdout.writeln( "[ $compart1Unit <-> $compart2Unit ] -> intersection is '$interSec']");
  return interSec;
}

/// Convert the decimal ASCII rucksack 'itemType' to the equivalent item 'Priority'
/// as provided in the puzzle.
/// Puzzle information:
/// -> Lowercase item types a through z have priorities 1 through 26 (NB: ASCII = 97 - 122)
/// ->  Uppercase item types A through Z have priorities 27 through 52 (NB: ASCII = 65 - 90)
int getPriority(int itemType) {
  int priority = 0;
  // convert from ASCII decimal to puzzle Priority by subtracting the difference
  if (itemType > 90) {
    priority = itemType - 96;
  } else {
    priority = itemType - 38;
  }
  // check the conversion is in the correct range
  if (priority < 1 || priority > 52) {
    stderr.writeln("ERROR: ruck sack item not on the allowed range (1 - 52)");
  }
  return priority;
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
  for (String allRuckSackContent in lines) {
    final int splitPoint = allRuckSackContent.length ~/ 2;
    //stdout.writeln( "Length : '${allRuckSackContent.length}' split at: '$splitPoint'");
    final compart1 = allRuckSackContent.substring(0, splitPoint);
    final compart2 =
        allRuckSackContent.substring(splitPoint, allRuckSackContent.length);
    final Set<int> uniqItems = getIntersection(compart1, compart2);
    //stdout.writeln( "'$allRuckSackContent' : '$compart1' <-> '$compart2' [${String.fromCharCode(uniqItems.first)}]");
    answer = answer + getPriority(uniqItems.first);
  }
  // Test data answer:    157
  // Puzzle data answer:  8515
  stdout.writeln("""

 >>  Advent of Code: Day 03 Part 1  <<
     -> The sum of the priorities of the item types is : '$answer'
""");
}
