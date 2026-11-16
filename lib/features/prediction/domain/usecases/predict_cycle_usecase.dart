// lib/features/prediction/domain/usecases/predict_cycle_usecase.dart

import 'dart:math' as math;
import '../../../cycle/data/models/cycle.dart';
import '../models/prediction_result.dart';

class PredictCycleUseCase {
  /// Returns a [PredictionResult] based on the provided list of past cycles.
  ///
  /// - Uses the last up to 6 cycles.
  /// - Applies a weighted average where newer cycles have higher weight.
  /// - Detects irregularity when the standard deviation of cycle lengths exceeds 4 days.
  /// - Confidence is calculated as the rounded standard deviation (± days).
  PredictionResult call(List<Cycle> cycles) {
    if (cycles.isEmpty) {
      throw ArgumentError('At least one cycle is required for prediction');
    }

    // Keep only the most recent six cycles (assume list is sorted oldest first, newest last).
    final recent = cycles.length > 6 ? cycles.sublist(cycles.length - 6) : cycles;

    // Weighted average: newest cycle weight = recent.length, second newest = recent.length-1 ... down to 1.
    int totalWeight = 0;
    double weightedLengthSum = 0;
    double weightedPeriodSum = 0;
    for (int i = 0; i < recent.length; i++) {
      final weight = recent.length - i; // newest gets highest weight
      totalWeight += weight;
      weightedLengthSum += recent[i].cycleLength * weight;
      weightedPeriodSum += recent[i].periodLength * weight;
    }
    final avgCycleLength = (weightedLengthSum / totalWeight).round();
    final avgPeriodLength = (weightedPeriodSum / totalWeight).round();

    // Standard deviation for confidence & irregularity detection.
    double mean = recent.map((c) => c.cycleLength).reduce((a, b) => a + b) / recent.length;
    double variance = recent
        .map((c) => math.pow(c.cycleLength - mean, 2) as double)
        .reduce((a, b) => a + b) / recent.length;
    double stdDev = math.sqrt(variance);
    int confidence = stdDev.round();
    bool irregular = stdDev > 4; // heuristic threshold for irregular cycles

    // Predict next period start based on the most recent cycle start date + avg.
    final lastCycle = recent.last;
    final nextPeriodStart = lastCycle.startDate.add(Duration(days: avgCycleLength));

    // Fertile window is typically 14 days before period start, lasting 5 days.
    final fertileStart = nextPeriodStart.subtract(const Duration(days: 14));
    final fertileEnd = fertileStart.add(const Duration(days: 4));
    final ovulationDay = fertileStart; // first day of fertile window is ovulation day

    return PredictionResult(
      nextPeriodStart: nextPeriodStart,
      fertileStart: fertileStart,
      fertileEnd: fertileEnd,
      ovulationDay: ovulationDay,
      confidenceDays: confidence,
      irregular: irregular,
    );
  }
}

