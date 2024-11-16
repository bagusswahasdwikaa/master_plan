import 'package:flutter/material.dart';
import '../models/data_layer.dart';
import '../provider/plan_provider.dart';

class PlanScreen extends StatefulWidget {
  final Plan plan;

  const PlanScreen({
    super.key,
    required this.plan,
  });

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late Plan plan;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    plan = widget.plan;
    scrollController = ScrollController()
      ..addListener(() {
        FocusScope.of(context).requestFocus(FocusNode());
      });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(plan.name),
      ),
      body: ValueListenableBuilder<List<Plan>>(
        valueListenable: plansNotifier,
        builder: (context, plans, child) {
          Plan currentPlan = plans.firstWhere((p) => p.name == plan.name);

          return Column(
            children: [
              Expanded(child: _buildList(currentPlan)),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    currentPlan.completenessMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: _buildAddTaskButton(context),
    );
  }

  Widget _buildAddTaskButton(BuildContext context) {
    ValueNotifier<List<Plan>> plansNotifier = PlanProvider.of(context);

    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        Plan currentPlan = plan;

        int planIndex = plansNotifier.value.indexWhere((p) => p.name == currentPlan.name);

        List<Task> updatedTasks = List<Task>.from(currentPlan.tasks)
          ..add(const Task(description: 'Tugas Baru'));

        plansNotifier.value = List<Plan>.from(plansNotifier.value)
          ..[planIndex] = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );

        setState(() {
          plan = Plan(
            name: currentPlan.name,
            tasks: updatedTasks,
          );
        });
      },
    );
  }

  Widget _buildList(Plan plan) {
    return ListView.builder(
      controller: scrollController,
      itemCount: plan.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(plan.tasks[index], index, context),
    );
  }

  Widget _buildTaskTile(Task task, int index, BuildContext context) {
    ValueNotifier<List<Plan>> planNotifier = PlanProvider.of(context);

    return ListTile(
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          Plan currentPlan = plan;

          int planIndex = planNotifier.value.indexWhere((p) => p.name == currentPlan.name);

          // Update tugas yang dipilih tanpa menghapus status lainnya
          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks);
          updatedTasks[index] = Task(
            description: task.description,
            complete: selected ?? false, // Update status complete
          );

          // Perbarui daftar tasks dalam Plan
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );

          // Memastikan UI terupdate
          setState(() {
            plan = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
          });
        },
      ),
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          Plan currentPlan = plan;

          int planIndex = planNotifier.value.indexWhere((p) => p.name == currentPlan.name);

          // Update deskripsi tugas tanpa menghapus status lainnya
          List<Task> updatedTasks = List<Task>.from(currentPlan.tasks);
          updatedTasks[index] = Task(
            description: text,
            complete: task.complete, // Pastikan status complete tetap sama
          );

          // Perbarui daftar tasks dalam Plan
          planNotifier.value = List<Plan>.from(planNotifier.value)
            ..[planIndex] = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );

          setState(() {
            plan = Plan(
              name: currentPlan.name,
              tasks: updatedTasks,
            );
          });
        },
      ),
    );
  }
}
