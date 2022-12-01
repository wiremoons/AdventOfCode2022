//
// @file day_01_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 01 Part 01.
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
  final inputFile = File('${Directory.current.path}/lib/day01/$inputFileName');
  //stdout.writeln(inputFile);
  if (!await inputFile.exists()) {
    stderr.writeln("ERROR: not found file: ${inputFile}");
    return "";
  }
  var length = await inputFile.length();
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
void day_01_part_01() async {
  final String input = await getPuzzleFileInput(true);
  if (input.isEmpty) {
    stderr.writeln("ERROR: No file input available.");
    exit(1);
  }
  // stdout.write(input);
  // stdout.writeln("\nstarting...");

  int calTotal = 0;
  int max = 0;
  int elf = 1;

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);
  lines.forEach((calorie) {
    //stdout.writeln("Adding calorie $calorie for $elf");
    if (calorie.isNotEmpty) {
      calTotal = calTotal + int.parse(calorie);
      //stdout.writeln("Running count for $elf is: '$calTotal'");
    } else {
      //stdout.writeln("Final total for $elf is: '$calTotal'");
      if (calTotal > max) {
        max = calTotal;
        calTotal = 0;
      } else {
        calTotal = 0;
      }
      //stdout.writeln("Running max calorie is: '$max'\n");
      elf++;
    }
  });
  calTotal > max ? max = calTotal : calTotal = 0;
  // Test data answer:    24000
  // Puzzle data answer:  69501
  stdout.writeln("""
 >>  Advent of Code: Day 01 Part 1  <<
     -> Max calorie total is: '$max'
     """);
}
