class Task {
  final String description;
  final bool complete;

  const Task({
    this.description = '',
    this.complete = false,
  });

  // Copy constructor untuk membuat salinan Task dengan perubahan tertentu
  Task copyWith({
    String? description,
    bool? complete,
  }) {
    return Task(
      description: description ?? this.description,
      complete: complete ?? this.complete,
    );
  }

  // Metode untuk mengubah status 'complete'
  Task toggleComplete() {
    return copyWith(complete: !complete);
  }

  @override
  String toString() {
    return 'Task(description: $description, complete: $complete)';
  }
}
