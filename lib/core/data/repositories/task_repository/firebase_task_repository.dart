import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'entities/entities.dart';
import 'task_repository.dart';

class FirebaseTaskRepository implements TaskRepository {
  final taskCollection = Firestore.instance.collection('tasks');

  @override
  Future<void> addNewTask(Task task) {
    return taskCollection.add(task.toEntity().toDocument());
  }

  @override
  Future<void> deleteTask(Task task) async {
    try {
      taskCollection.document(task.id).delete();
    } catch (ex) {
      rethrow;
    }
  }

  @override
  Stream<List<Task>> tasks() {
    return taskCollection.snapshots().map((snapshot) {
      return snapshot.documents
          .map((doc) => Task.fromEntity(TaskEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Stream<QuerySnapshot> snapshots() {
    return taskCollection.reference().snapshots();
  }

  @override
  Stream<QuerySnapshot> subTasksSnapshots(String taskId) {
    return taskCollection
        .document(taskId)
        .collection('subTasks')
        .reference()
        .snapshots();
  }

  @override
  Future<void> updateTask(Task update) {
    return taskCollection
        .document(update.id)
        .updateData(update.toEntity().toDocument());
  }

  @override
  Future<Task> getTask(String id) async {
    var document = await taskCollection.document(id).get();
    return Task.fromEntity(TaskEntity.fromSnapshot(document));
  }

  @override
  Future<Task> updateTaskTitle(String taskId, String title) async {
    await taskCollection.document(taskId).updateData({'title': title});
    return await getTask(taskId);
  }

  @override
  Future<Task> updateTaskImage({String taskId, String fireBaseFileUrl}) async {
    await taskCollection
        .document(taskId)
        .updateData({'imageUrl': fireBaseFileUrl});
    return await getTask(taskId);
  }

  @override
  Future<Task> updateTaskDueDate(String taskId, DateTime date) async {
    taskCollection.document(taskId).updateData({'dueDateTime': date});
    return await getTask(taskId);
  }

  @override
  Future<Task> updateTaskDuration(String taskId, int duration) async {
    taskCollection.document(taskId).updateData({'duration': duration});
    return await getTask(taskId);
  }

//  @override
//  Future<Task> updateSubTask(String taskId, List<String> content) async {
//    await taskCollection
//        .document(taskId)
//        .updateData({'subTasks': FieldValue.arrayUnion(content)});
//
//    return await getTask(taskId);
//  }

  @override
  Stream<List<SubTask>> subTasksForTask(String taskId) {
    return taskCollection
        .document(taskId)
        .collection('subTasks')
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((doc) => SubTask.fromEntity(SubTaskEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<SubTask> addSubTask(SubTask subTask, String taskId) async {
    String _subTaskId;

    taskCollection
        .document(taskId)
        .collection('subTasks')
        .add(subTask.toEntity().toDocument())
        .then((docRef) {
      _subTaskId = docRef.documentID;
    });
    return getSubTask(taskId: taskId, subTaskId: _subTaskId);
  }

  @override
  Future<void> deleteSubTask(SubTask subTask, String taskId) async {
    taskCollection
        .document(taskId)
        .collection('subTasks')
        .document(subTask.id)
        .delete();
  }

  @override
  Future<SubTask> getSubTask({String taskId, String subTaskId}) async {
    var document = await taskCollection
        .document(taskId)
        .collection('subTasks')
        .document(subTaskId)
        .get();
    return SubTask.fromEntity(SubTaskEntity.fromSnapshot(document));
  }

  @override
  Future<SubTask> updateSubTaskCompletion(
      {String taskId, String subTaskId, bool isCompleted}) async {
    taskCollection
        .document(taskId)
        .collection('subTasks')
        .document(subTaskId)
        .updateData({'isCompleted': isCompleted});

    return getSubTask(taskId: taskId, subTaskId: subTaskId);
  }

  @override
  Future<SubTask> updateSubTaskContent(
      {String taskId, String subTaskId, String content}) async {
    taskCollection
        .document(taskId)
        .collection('subTasks')
        .document(subTaskId)
        .updateData({'content': content});

    return getSubTask(taskId: taskId, subTaskId: subTaskId);
  }

  @override
  Future<SubTask> updateSubTask(String taskId, SubTask subTask) async {
    taskCollection
        .document(taskId)
        .collection('subTasks')
        .document(subTask.id)
        .updateData(subTask.toEntity().toDocument());

    return getSubTask(taskId: taskId, subTaskId: subTask.id);
  }
}
