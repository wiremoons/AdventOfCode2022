#!/usr/bin/env -S dart
//
// @file day_07_part_01.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 07 Part 01.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 07 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The program can be run with Dart language: https://dart.dev/
//
// Disable some specific linting rules in this file only
// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';
import 'dart:convert';

// import local class:
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
  List<String> inputLine = [];
  final dirStack = Stack<String>();
  final fileMap = Map<String, int>();
  final dirMap = Map<String, int>();

  LineSplitter ls = LineSplitter();
  List<String> lines = ls.convert(input);

  for (String line in lines) {
    //stdout.write("input = '$line' -->\t");
    inputLine = line.split(" ");
    switch (inputLine.first) {
      case "\$":
        {
          //print("command: ${inputLine.last}");
          if ((inputLine.length == 3) && (inputLine.last == "..")) {
            dirStack.pop();
            //print(" >> current dir 'post-pop' is: '${dirStack.peek}'");
          } else if (inputLine.length == 3) {
            dirStack.push(inputLine.last);
            String dirPath = "${dirStack.showPath()}/".replaceFirst("//", "/");
            dirMap.addAll({dirPath: 0});
            //print(" >> current dir is: '${dirStack.peek}'");
          }
          break;
        }
      case "dir":
        {
          //print("directory listed: ${inputLine.last}");
          //print(" >> current dir is: '${dirStack.peek}'");
          break;
        }
      default:
        {
          String fileAndPath = "${dirStack.showPath()}/${inputLine.last}"
              .replaceFirst("//", "/");
          int fileSize = int.parse(inputLine.first);
          fileMap.addAll({fileAndPath: fileSize});
          //print("file: '${fileAndPath}' size: '${fileSize}'");
        }
    }
  }

  // sum up all sizes for any directory and it sub-directories
  dirMap.forEach((dir, dirSize) {
    fileMap.forEach((file, fileSize) {
      //stdout.write("Matching: '${dir}' to '${file}' ->");
      if (dir.matchAsPrefix(file) != null) {
        int newDirSize = dirSize + fileSize;
        dirMap.update(dir, (dirSize) => dirSize + newDirSize);
        //stdout.writeln("MATCHED  [${newDirSize} (${dirSize})]");
      } else {
        //stdout.writeln("NO MATCH");
      }
    });
  });

  // find all directory and sum them where they are less than 100,000
  dirMap.forEach((dir, size) {
    //print("Directory: '${dir}' is size: ${size}");
    if (size <= 100000) {
      answer = answer + size;
    }
  });

  //print(fileMap);
  //print(dirMap);

  // Test data answer:   95437 (a & e)
  // Puzzle data answer: 1453349
  stdout.writeln("""

 >>  Advent of Code: Day 07 Part 1  <<
     -> The sum of the total sizes of those directories of at most 100,000 is: '$answer'
""");
}
