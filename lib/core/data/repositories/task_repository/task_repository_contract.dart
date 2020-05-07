import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_repository.dart';

abstract class TaskRepository {
  Stream<List<Task>> getTasksByCircle(int circleId);

  Future<void> addNewTask(Task task);

  Future<void> deleteTask(String id);

  Stream<QuerySnapshot> snapshots();

  Future<void> updateTask(Task task);

  Future<Task> getTaskById(String id);

  //Future<Task> updateTaskTitle(String taskId, String title);

  Future<Task> updateTaskImage({String taskId, String fireBaseFileUrl});

  Future<Task> updateTaskDueDate(String taskId, DateTime dateTime);

  Future<Task> setTaskEndExecutionDateTime(String taskId, DateTime dateTime);
}
