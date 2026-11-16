// Cycle model
class Cycle {
  final DateTime startDate; // first day of period
  final int cycleLength; // total length of the cycle (days)
  final int periodLength; // length of bleeding (days)

  Cycle({required this.startDate, required this.cycleLength, required this.periodLength});
}

