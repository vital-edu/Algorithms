import 'package:algo/chapters/1/sections/2/exercise_11.dart';
import 'package:algo/utils/assert.dart';

main(List<String> args) {
  Assert.equal(Transaction('Eduardo', SmartDate(1, 2, 2021), 2340),
      '01/02/2021: 2340.00 to Eduardo');
  final transaction = Transaction.from('01/02/2021: 2340.00 to Eduardo Vital');
  Assert.equal(transaction.who, 'Eduardo Vital');
  Assert.equal(transaction.date, '01/02/2021');
  Assert.equal(transaction.amount, 2340.00);

  Assert.equal(
      transaction, Transaction('Eduardo Vital', SmartDate(1, 2, 2021), 2340));
}

class Transaction {
  final String _who;
  final SmartDate _date;
  final double _amount;

  Transaction(this._who, this._date, this._amount) {
    if (amount <= 0) throw ArgumentError('Invalid amount');
  }

  factory Transaction.from(String transaction) {
    RegExp regExp =
        RegExp(r'^([\d]{1,2}/[\d]{1,2}/\d+): (\d+(?:\.[\d]{2})?) to ([\w ]+)$');

    final matches = regExp.allMatches(transaction);
    if (matches.isEmpty ||
        matches.first == null ||
        matches.first.groupCount != 3) {
      throw ArgumentError(
          'Invalid format. Transaction should be in the format "<mm/dd/yyyy>: <amount> <person>": $transaction');
    }

    final date = SmartDate.from(matches.first.group(1));
    final amount = double.tryParse(matches.first.group(2));
    final who = matches.first.group(3);

    if (amount == null) throw ArgumentError('Invalid amount: $amount');

    return Transaction(who, date, amount);
  }

  String get who => _who;
  Date get date => _date;
  double get amount => _amount;

  @override
  operator ==(Object other) {
    if (other is String) {
      return other == this.toString();
    } else if (other is Transaction) {
      return (who == other.who && date == other.date && amount == other.amount);
    }
    return false;
  }

  @override
  int get hashCode {
    final twoHashes = who.hashCode * date.hashCode * 31;
    return twoHashes + amount.hashCode * 31;
  }

  @override
  String toString() => '$date: ${amount.toStringAsFixed(2)} to $who';
}
