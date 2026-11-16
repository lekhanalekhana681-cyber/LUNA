// lib/features/prediction/domain/models/prediction_result.dart

class PredictionResult {
  /// Predicted start date of the next period.
  final DateTime nextPeriodStart;

  /// Predicted fertile window start (inclusive).
  final DateTime fertileStart;

  /// Predicted fertile window end (inclusive).
  final DateTime fertileEnd;

  /// Predicted ovulation day.
  final DateTime ovulationDay;

  /// Confidence in days (±). Lower is better.
  final int confidenceDays;

  /// Whether the recent cycles are considered irregular.
  final bool irregular;

  const PredictionResult({
    required this.nextPeriodStart,
    required this.fertileStart,
    required this.fertileEnd,
    required this.ovulationDay,
    required this.confidenceDays,
    required this.irregular,
  });
}

