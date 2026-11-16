import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/ui/theme.dart';
import 'package:intl/intl.dart';

final onboardingProvider = StateProvider<OnboardingData>((ref) => OnboardingData.empty());

class OnboardingData {
  final String name;
  final int age;
  final int avgCycleLength;
  final int periodLength;
  final DateTime? lastPeriodDate;

  const OnboardingData({
    required this.name,
    required this.age,
    required this.avgCycleLength,
    required this.periodLength,
    required this.lastPeriodDate,
  });

  factory OnboardingData.empty() => const OnboardingData(
        name: '',
        age: 0,
        avgCycleLength: 28,
        periodLength: 5,
        lastPeriodDate: null,
      );

  OnboardingData copyWith({
    String? name,
    int? age,
    int? avgCycleLength,
    int? periodLength,
    DateTime? lastPeriodDate,
  }) =>
      OnboardingData(
        name: name ?? this.name,
        age: age ?? this.age,
        avgCycleLength: avgCycleLength ?? this.avgCycleLength,
        periodLength: periodLength ?? this.periodLength,
        lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
      );
}

class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(onboardingProvider);
    final controllerName = TextEditingController(text: data.name);
    final controllerAge = TextEditingController(text: data.age > 0 ? data.age.toString() : '');
    final controllerAvg = TextEditingController(text: data.avgCycleLength.toString());
    final controllerPeriod = TextEditingController(text: data.periodLength.toString());
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Luna')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Let’s set up your profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(
              controller: controllerName,
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (v) => ref.read(onboardingProvider.notifier).state = data.copyWith(name: v),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controllerAge,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Age'),
              onChanged: (v) => ref.read(onboardingProvider.notifier).state = data.copyWith(age: int.tryParse(v) ?? 0),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controllerAvg,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Average cycle length (days)'),
              onChanged: (v) => ref.read(onboardingProvider.notifier).state = data.copyWith(avgCycleLength: int.tryParse(v) ?? 28),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controllerPeriod,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Period length (days)'),
              onChanged: (v) => ref.read(onboardingProvider.notifier).state = data.copyWith(periodLength: int.tryParse(v) ?? 5),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Last period start date'),
              subtitle: Text(data.lastPeriodDate != null ? dateFormat.format(data.lastPeriodDate!) : 'Not set'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: data.lastPeriodDate ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  ref.read(onboardingProvider.notifier).state = data.copyWith(lastPeriodDate: picked);
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // In a real app we would persist and navigate to Dashboard
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved!')));
              },
              child: const Text('Save & Continue'),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Luna is not a medical device or contraceptive.',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

