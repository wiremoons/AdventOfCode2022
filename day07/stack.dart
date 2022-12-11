//
// @file stack.dart
// @brief Class to create a simple stack in Dart.
//
// @author simon rowe <simon@wiremoons.com>
// @license open-source released under "MIT License"
//
// @date originally created: 06 Dec 2022
//
// @details Advent of Code (AOC) 2022 Puzzle solution. See: https://adventofcode.com/2022/
//
// @note The code can be used as a class with Dart language: https://dart.dev/
//
// Disable some specific linting rules in this file only
// ignore_for_file: unnecessary_brace_in_string_interps

class Stack<S> {
  final _StackList = <S>[];

  // `push` : add a value to the stack
  void push(S value) => _StackList.add(value);
  // `pop` : extract a value from the stack
  S pop() => _StackList.removeLast();

  // 'peek' : obtain (but dont remove as in 'pop') the value from the stack
  S get peek => _StackList.last;

  // checks to see if the stack is empty or not
  bool get isEmpty => _StackList.isEmpty;
  bool get isNotEmpty => _StackList.isNotEmpty;

  // display the stack as a path: [/,a,b,c] -> /a/b/c
  String showPath() {
    if (_StackList.isEmpty) {
      return "";
    }
    return _StackList.join('/').replaceFirst("//", "/");
  }

  @override
  String toString() => _StackList.toString();
}

// Example usage
//
// void main() {
//   final stackOne = Stack<String>();

//   stackOne.push("The Maple Tree");
//   stackOne.push("The Dog and Duck");
//   stackOne.push("The Queen's Head");

//   while (stackOne.isNotEmpty) {
//     print(stackOne.pop());
//   }
// }
// Output:
//   The Maple Tree
//   The Dog and Duck
//   The Queen's Head