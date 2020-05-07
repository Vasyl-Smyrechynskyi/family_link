import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final DateTime dueDateTime;
  final DateTime executionStartDateTime;
  final DateTime executionEndDateTime;
  final List<String> attachmentsUrls;

  TaskEntity(
      this.id,
      this.title,
      this.description,
      this.dueDateTime,
      this.executionStartDateTime,
      this.executionEndDateTime,
      this.attachmentsUrls);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dueDateTime": dueDateTime,
      "executionStartDateTime": executionStartDateTime,
      "executionEndDateTime": executionEndDateTime,
      "attachmentsUrls": attachmentsUrls
    };
  }

  @override
  String toString() {
    return 'TaskEntity{id: $id, title: $title, description: $description,'
        ' dueDateTime: $dueDateTime, executionStartDateTime: $executionStartDateTime, executionEndDateTime: $executionEndDateTime, attachmentsUrls: $attachmentsUrls}';
  }

  static TaskEntity fromJson(Map<String, Object> json) {
    return TaskEntity(
        json["id"] as String,
        json["title"] as String,
        json["description"] as String,
        DateTime.fromMillisecondsSinceEpoch(
            (json["dueDateTime"] as Timestamp).millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(
            (json["executionStartDateTime"] as Timestamp).millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(
            (json["executionEndDateTime"] as Timestamp).millisecondsSinceEpoch),
        json["attachmentsUrls"] as List<String>);
  
  }

  static TaskEntity fromSnapshot(DocumentSnapshot snap) {
    return TaskEntity(
        snap.documentID,
        snap.data['title'],
        snap.data['description'],
        DateTime.fromMillisecondsSinceEpoch(
            snap.data['dueDateTime'].millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(
            snap.data['executionStartDateTime'].millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(
            snap.data['executionEndDateTime'].millisecondsSinceEpoch),
        snap.data['attachmentsUrls']);
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "dueDateTime": dueDateTime,
      "executionStartDateTime": executionStartDateTime,
      "executionEndDateTime": executionEndDateTime,
      "attachmentsUrls": attachmentsUrls
    };
  }

  @override
  List<Object> get props => [
        id,
        title,
        description,
        dueDateTime,
        executionStartDateTime,
        executionEndDateTime,
        attachmentsUrls
      ];
}
