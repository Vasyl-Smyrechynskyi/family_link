import '../entities/entities.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;
  final int duration;
  final DateTime dueDateTime;
  final DateTime executionDateTime;
  final String imageUrl;
  String userEmail;

  Task(
      {String id,
      String title,
      this.description,
      this.completed = false,
      this.duration,
      this.dueDateTime,
      this.executionDateTime,
      this.imageUrl,
      this.userEmail})
      : this.id = id,
        this.title = title ?? '';

  Task copyWith(
      {String id,
      String title,
      String description,
      bool completed,
      int duration,
      DateTime dueDateTime,
      DateTime executionDateTime,
      String imageUrl,
      String userEmail}) {
    return Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        completed: completed ?? this.completed,
        duration: duration ?? this.duration,
        dueDateTime: dueDateTime ?? this.dueDateTime,
        executionDateTime: executionDateTime ?? this.executionDateTime,
        imageUrl: imageUrl ?? this.imageUrl,
        userEmail: userEmail ?? this.userEmail);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      completed.hashCode ^
      duration.hashCode ^
      dueDateTime.hashCode ^
      executionDateTime.hashCode ^
      imageUrl.hashCode ^
      userEmail.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          completed == other.completed &&
          duration == other.duration &&
          dueDateTime == other.dueDateTime &&
          executionDateTime == other.executionDateTime &&
          imageUrl == other.imageUrl &&
          userEmail == other.userEmail;

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, completed: $completed, duration: $duration, '
        'dueDateTime: $dueDateTime, executionDateTime: $executionDateTime, imageUrl: $imageUrl, userEmail: $userEmail}';
  }

  TaskEntity toEntity() {
    return TaskEntity(id, title, description, completed, duration, dueDateTime,
        executionDateTime, imageUrl, userEmail);
  }

  static Task fromEntity(TaskEntity entity) {
    return Task(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        completed: entity.completed ?? false,
        duration: entity.duration,
        dueDateTime: entity.dueDateTime,
        executionDateTime: entity.executionDateTime,
        imageUrl: entity.imageUrl,
        userEmail: entity.userEmail);
  }
}
