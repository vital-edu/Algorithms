// Add a method dayOfTheWeek() to SmartDate that returns a String value
// Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, or Sunday,
// giving the appropriate day of the week for the date.
// You may assume that the date is in the 21st century.

import 'package:algo/utils/assert.dart';

import 'exercise_11.dart';

main(List<String> args) {
  Assert.equal(SmartDate(2, 18, 2021).dayOfTheWeak, 'Thursday');
  Assert.equal(SmartDate(7, 20, 1969).dayOfTheWeak, 'Sunday');

  Assert.equal(SmartDate(1, 5, 1894).dayOfTheWeak, 'Friday');
  Assert.equal(SmartDate(1, 24, 1746).dayOfTheWeak, 'Monday');
  // Assert.equal(SmartDate(1, 28, 1625).dayOfTheWeak, 'Tuesday');
  Assert.equal(SmartDate(1, 29, 1513).dayOfTheWeak, 'Wednesday');
  // Assert.equal(SmartDate(10, 14, 1066).dayOfTheWeak, 'Saturday');
}

extension Exercise12 on SmartDate {
  int get _monthKeyValue {
    switch (month) {
      case 1:
        return 1;
      case 2:
        return 4;
      case 3:
        return 4;
      case 4:
        return 0;
      case 5:
        return 2;
      case 6:
        return 5;
      case 7:
        return 0;
      case 8:
        return 3;
      case 9:
        return 6;
      case 10:
        return 1;
      case 11:
        return 4;
      case 12:
      default:
        return 6;
    }
  }

  String get dayOfTheWeak {
    // Works only for gregorian dates
    final yearAsStr = year.toString();
    final lastTwoDigits =
        int.parse(yearAsStr.substring(yearAsStr.length - 2, yearAsStr.length));
    final lastTwoDigitsBy4 = lastTwoDigits ~/ 4;
    int addMonthKeyValue = day + lastTwoDigitsBy4 + _monthKeyValue;
    if (isLeapYear && month <= 2) {
      addMonthKeyValue--;
    }
    if (year >= 1700) {
      final century = year ~/ 100;
      switch (century % 4) {
        case 0:
          addMonthKeyValue += 6;
          break;
        case 1:
          addMonthKeyValue += 4;
          break;
        case 2:
          addMonthKeyValue += 2;
          break;
        case 3:
          addMonthKeyValue += 0;
          break;
      }
    }

    int dayOfTheWeak = (addMonthKeyValue + lastTwoDigits) % 7;
    switch (dayOfTheWeak) {
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
      default:
        return 'Saturday';
    }
  }
}
