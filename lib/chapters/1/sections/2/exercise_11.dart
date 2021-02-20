import '../../../../utils/assert.dart';

main(List<String> args) {
  // from(String date)
  Assert.equal(SmartDate.from('10/13/2029'), '10/13/2029');
  Assert.raiseException(() => SmartDate.from('131/10/2029'),
      errorMessage: 'Invalid date.');

  // Invalid months
  Assert.raiseException(() => SmartDate(-1, 1, 2001),
      errorMessage: 'month must be between 1 and 12');

  Assert.raiseException(() => SmartDate(0, 1, 2001),
      errorMessage: 'month must be between 1 and 12');
  Assert.raiseException(() => SmartDate(13, 1, 2001),
      errorMessage: 'month must be between 1 and 12');

  // Invalid days
  Assert.raiseException(() => SmartDate(1, 0, 2001),
      errorMessage: 'day cannot be less that 1');
  Assert.raiseException(() => SmartDate(1, -1, 2001),
      errorMessage: 'day cannot be less that 1');

  // Invalid days of months with 30 days
  Assert.raiseException(() => SmartDate(4, 31, 2001),
      errorMessage: 'day of the month 4 cannot be greater than 30');
  Assert.raiseException(() => SmartDate(6, 31, 2001),
      errorMessage: 'day of the month 6 cannot be greater than 30');
  Assert.raiseException(() => SmartDate(9, 31, 2001),
      errorMessage: 'day of the month 9 cannot be greater than 30');
  Assert.raiseException(() => SmartDate(11, 31, 2001),
      errorMessage: 'day of the month 11 cannot be greater than 30');

  // Valid days of months with 31 days
  Assert.notRaiseException(() => SmartDate(1, 31, 2001));
  Assert.notRaiseException(() => SmartDate(3, 31, 2001));
  Assert.notRaiseException(() => SmartDate(5, 31, 2001));
  Assert.notRaiseException(() => SmartDate(7, 31, 2001));
  Assert.notRaiseException(() => SmartDate(8, 31, 2001));
  Assert.notRaiseException(() => SmartDate(10, 31, 2001));
  Assert.notRaiseException(() => SmartDate(12, 31, 2001));

  // Invalid days of february
  Assert.raiseException(() => SmartDate(2, 31, 2001),
      errorMessage: 'day of the month 2 cannot be greater than 28');
  Assert.raiseException(() => SmartDate(2, 30, 2021),
      errorMessage: 'day of the month 2 cannot be greater than 28');

  // Valid day of february
  Assert.notRaiseException(() => SmartDate(2, 28, 2021));

  // Valid days of of february (leap years)
  Assert.notRaiseException(() => SmartDate(2, 29, 2000));
  Assert.notRaiseException(() => SmartDate(2, 29, 2400));

  // Invalid days of of february (non-leap years)
  Assert.raiseException(() => SmartDate(2, 29, 1800));
  Assert.raiseException(() => SmartDate(2, 29, 1900));
  Assert.raiseException(() => SmartDate(2, 29, 2100));
  Assert.raiseException(() => SmartDate(2, 29, 2200));
  Assert.raiseException(() => SmartDate(2, 29, 2300));
  Assert.raiseException(() => SmartDate(2, 29, 2500));
}

abstract class Date {
  int get month;
  int get day;
  int get year;

  @override
  String toString() =>
      '${month.toString().padLeft(2, '0')}/${day.toString().padLeft(2, '0')}/$year';

  operator ==(Object other) {
    if (other is String) {
      return other == toString();
    } else if (other is Date) {
      return (day == other.day && month == other.month && year == other.year);
    }
    return false;
  }

  @override
  int get hashCode {
    final twoHashes = day.hashCode + month.hashCode * 31;
    return twoHashes + year.hashCode * 31;
  }
}

class SmartDate extends Date {
  int _year;
  int _month;
  int _day;

  SmartDate(int month, int day, int year)
      : this._year = year,
        this._month = month,
        this._day = day {
    if (month < 1 || month > 12)
      throw ArgumentError(
          'month must be between 1 and 12 (inclusive range): $month');
    if (day < 1) throw ArgumentError('day cannot be less that 1: $day');

    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        if (day > 31)
          throw ArgumentError(
              'day of the month $month cannot be greater than 31: $day');
        break;
      case 2:
        int maxDay = isLeapYear ? 29 : 28;
        if (day > maxDay) {
          String complementaryText = (isLeapYear && day == 29)
              ? '$maxDay in non-leap years'
              : '$maxDay ';
          throw ArgumentError(
              'day of the month $month cannot be greater than $complementaryText: $day');
        }
        break;
      case 4:
      case 6:
      case 9:
      case 11:
      default:
        if (day > 30)
          throw ArgumentError(
              'day of the month $month cannot be greater than 30: $day');
    }

    if (month > 12 || month < 1) throw ArgumentError('invalid month');
  }

  factory SmartDate.from(String date) {
    RegExp regExp = RegExp(r'^([\d]{1,2})/([\d]{1,2})/(\d+)$');

    final matches = regExp.allMatches(date);
    if (regExp.allMatches(date).isEmpty ||
        matches.length != 1 ||
        matches.first.groupCount != 3) {
      throw ArgumentError(
          'Invalid date. The date should be in the format "dd/mm/aaaa": $date');
    }

    int mm = int.tryParse(matches.first.group(1));
    int dd = int.tryParse(matches.first.group(2));
    int aaaa = int.tryParse(matches.first.group(3));

    if (mm == null) throw ArgumentError('Invalid month: $mm');
    if (dd == null) throw ArgumentError('Invalid day: $dd');
    if (aaaa == null) throw ArgumentError('Invalid year: $aaaa');

    return SmartDate(mm, dd, aaaa);
  }

  bool get isLeapYear {
    if (year % 4 != 0) return false;

    return (year % 100 == 0 && year % 400 == 0);
  }

  @override
  int get day => _day;

  @override
  int get month => _month;

  @override
  int get year => _year;
}
