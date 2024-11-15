import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';
import '../views/plan_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<Plan> planNotifier = ValueNotifier<Plan>(
    const Plan(name: 'Master Plan Bagus Wahasdwika', tasks: []),
  );

  @override
  Widget build(BuildContext context) {
    return PlanProvider(
      notifier: planNotifier,
      child: MaterialApp(
        title: 'Plan App',
        theme: ThemeData(primarySwatch: Colors.red),
        home: const PlanScreen(),
      ),
    );
  }
}
