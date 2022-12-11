#!/usr/bin/env -S dart
//
// @file day_07_part_02.dart
// @brief Advent of Code (AOC) 2022 Puzzle solution for:  Day 07 Part 02.
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

  // All the total sizes, capacities, and the target free space needed
  const int totalCapacity = 70000000;
  int totalSize = dirMap["/"] as int;
  int freeSpace = totalCapacity - totalSize;
  int targetSpace = 30000000 - freeSpace;
  List<int> dirSizesList = [];

  print("\nDirectory sizes:");
  dirMap.forEach((dir, size) {
    //print("Directory: '${dir}' is size: ${size}");
    // capture each directory size into a list
    dirSizesList.add(size);
  });

  // Output the known information:
  stdout.writeln("\nFilesystem capacity: '${totalCapacity}'");
  stdout.writeln("Used space: '${totalSize}'");
  stdout.writeln("Free space: '${freeSpace}'");
  stdout.writeln("Required additional free space: '${targetSpace}'");

  // sort the list of directory sizes
  dirSizesList.sort((a, b) => a.compareTo(b));
  //print(dirSizesList);

  // find the closest largest number match (ie first one larger than the target size)
  for (int i = 0; i < dirSizesList.length; i++) {
    if (dirSizesList[i] > targetSpace) {
      answer = dirSizesList[i];
      break;
    }
  }

  // Test data answer:   24933642
  // Puzzle data answer: 2948823
  stdout.writeln("""

 >>  Advent of Code: Day 07 Part 2  <<
     -> The directory closest to the target space size (${targetSpace}) is: '$answer'
""");
}
