import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class SubTaskEntity extends Equatable {
  final String id;
  final String content;
  final bool isCompleted;
  final DateTime createdAt;

  SubTaskEntity(this.id, this.content, this.isCompleted, this.createdAt);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "content": content,
      "isCompleted": isCompleted,
      "createdAt": createdAt,
    };
  }

  @override
  String toString() {
    return 'TaskEntity{id: $id, content: $content, isCompleted: $isCompleted, createdAt: $createdAt}';
  }

  static SubTaskEntity fromJson(Map<String, Object> json) {
    return SubTaskEntity(
      json["id"] as String,
      json["content"] as String,
      json["isCompleted"] as bool,
      DateTime.fromMillisecondsSinceEpoch(
          (json["createdAt"] as Timestamp).millisecondsSinceEpoch),
    );
  }

  static SubTaskEntity fromSnapshot(DocumentSnapshot snap) {
    return SubTaskEntity(
      snap.documentID,
      snap.data['content'],
      snap.data['isCompleted'],
      DateTime.fromMillisecondsSinceEpoch(
          snap.data['createdAt'].millisecondsSinceEpoch),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "content": content,
      "isCompleted": isCompleted,
      "createdAt": createdAt
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
