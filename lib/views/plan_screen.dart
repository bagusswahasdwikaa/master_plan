import '../models/data_layer.dart';
import 'package:flutter/material.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  Plan plan = const Plan(); // Inisialisasi objek Plan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ganti ‘Namaku’ dengan nama panggilan Anda
      appBar: AppBar(title: const Text('Master Plan Bagus Wahasdwika', style: TextStyle(color: Colors.white),),backgroundColor: const Color.fromARGB(255, 176, 39, 39),), 
      body: _buildList(),
      floatingActionButton: _buildAddTaskButton(),
    );
  }

  // Widget untuk tombol tambah rencana
  Widget _buildAddTaskButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        setState(() {
          plan = Plan(
            name: plan.name,
            tasks: List<Task>.from(plan.tasks)
              ..add(const Task(description: 'Tugas Baru')),
          );
        });
      },
    );
  }

  // Widget untuk menampilkan daftar tugas
  Widget _buildList() {
    return ListView.builder(
      itemCount: plan.tasks.length, // Jumlah item dalam daftar
      itemBuilder: (context, index) =>
          _buildTaskTile(plan.tasks[index], index), // Widget tiap item
    );
  }

  // Widget untuk setiap item dalam daftar tugas
  Widget _buildTaskTile(Task task, int index) {
    return ListTile(
      // Checkbox untuk mengubah status tugas (complete)
      leading: Checkbox(
        value: task.complete,
        onChanged: (selected) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: task.description,
                  complete: selected ?? false,
                ),
            );
          });
        },
      ),
      // TextFormField untuk mengedit deskripsi tugas
      title: TextFormField(
        initialValue: task.description,
        onChanged: (text) {
          setState(() {
            plan = Plan(
              name: plan.name,
              tasks: List<Task>.from(plan.tasks)
                ..[index] = Task(
                  description: text,
                  complete: task.complete,
                ),
            );
          });
        },
      ),
    );
  }
}
