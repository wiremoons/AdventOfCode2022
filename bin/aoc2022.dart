#!/usr/bin/env -S dart

import 'dart:io';
import 'package:aoc2022/aoc2022.dart';

// read args to get day and part - or display help
// use day and part to call correct puzzle solution file
void main(List<String> arguments) {
  stdout.writeln("");

  String day = "01";
  String part = "01";
  runDayPart(day, part);

  day = "01";
  part = "02";
  runDayPart(day, part);
}
