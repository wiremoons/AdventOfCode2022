import 'day01/day_01_part_01.dart';
import 'day01/day_01_part_02.dart';
import 'day02/day_02_part_01.dart';
import 'day02/day_02_part_02.dart';

void runDayPart(String day, String part) {
  String runme = "day_${day}_part_${part}";
  switch (runme) {
    case "day_01_part_01":
      day_01_part_01();
      break;
    case "day_01_part_02":
      day_01_part_02();
      break;
    case "day_02_part_01":
      day_02_part_01();
      break;
    case "day_02_part_02":
      day_02_part_02();
      break;
    default:
      print("Invalid choice");
      break;
  }
}
