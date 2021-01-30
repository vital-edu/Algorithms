import 'dart:math';

final Random random = Random();
final List<double> theoricalProbability = _calculateTheoricalProbability();
const int maxSum = 13;

int _rollDice() => random.nextInt(6) + 1;
int _rollTwoDices() => _rollDice() + _rollDice();
String _normalize(double n) => n.toStringAsFixed(3);

main(List<String> args) {
  int maxThrows;
  if (args.length == 1) {
    maxThrows = int.tryParse(args.first);
  }

  if (maxThrows == null) {
    print(
      'Making empirical tests to match theorical result. This can take several minutes...',
    );
    int calculatedThrows = _discoverThrowsNumber();
    print(
      'The dices were throw "$calculatedThrows" times to match the theorical probability.',
    );
    return;
  }

  int throws = 0;
  List<int> distribution = List.filled(maxSum, 0);

  while (throws <= maxThrows) {
    int sum = _rollTwoDices();
    distribution[sum] += 1;
    throws++;
  }

  print(
      'theorical probability: ${theoricalProbability.map((e) => _normalize(e)).join(', ')}');
  print(
      'empirical probability: ${_extractProbability(distribution, throws).map((e) => _normalize(e)).join(', ')}');
}

int _discoverThrowsNumber() {
  List<int> distribution = List.filled(maxSum, 0);
  int throws = 0;
  do {
    int sum = _rollTwoDices();
    distribution[sum] += 1;
    throws++;
  } while (!_doesEmpiricDataMatchProbability(distribution, theoricalProbability,
      throws: throws));

  return throws;
}

List<double> _extractProbability(List<int> distribution, int throws) {
  return distribution.map((occurencies) => occurencies / throws).toList();
}

bool _doesEmpiricDataMatchProbability(
    List<int> empiricDistribution, List<double> probability,
    {int throws}) {
  final empiricProbability = _extractProbability(empiricDistribution, throws);

  for (int i = 2; i < probability.length; i++) {
    if (_normalize(empiricProbability[i]) != _normalize(probability[i])) {
      return false;
    }
  }

  return true;
}

List<double> _calculateTheoricalProbability() {
  const int SIDES = 6;
  List<double> dist = List<double>.filled(2 * SIDES + 1, 0);

  for (int i = 1; i <= SIDES; i++) {
    for (int j = 1; j <= SIDES; j++) {
      dist[i + j] += 1.0;
    }
  }

  for (int k = 2; k <= 2 * SIDES; k++) {
    dist[k] /= 36.0;
  }

  return dist;
}
