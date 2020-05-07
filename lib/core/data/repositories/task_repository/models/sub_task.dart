// import 'package:meta/meta.dart';

// import '../entities/entities.dart';

// @immutable
// class SubTask {
//   final String id;
//   final bool isCompleted;
//   final String content;
//   final DateTime createdAt;

//   const SubTask(
//       {String id,
//       String content = '',
//       this.isCompleted = false,
//       DateTime createdAt})
//       : this.id = id,
//         this.content = content ?? '',
//         this.createdAt = createdAt;

//   SubTask copyWith(
//       {String id, String content, bool isCompleted, DateTime createdAt}) {
//     return SubTask(
//         id: id ?? this.id,
//         content: content ?? this.content,
//         isCompleted: isCompleted ?? this.isCompleted,
//         createdAt: createdAt ?? this.createdAt);
//   }

//   @override
//   int get hashCode =>
//       id.hashCode ^
//       content.hashCode ^
//       isCompleted.hashCode ^
//       createdAt.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is SubTask &&
//           runtimeType == other.runtimeType &&
//           id == other.id &&
//           content == other.content &&
//           isCompleted == other.isCompleted &&
//           createdAt == other.createdAt;

//   @override
//   String toString() {
//     return 'SubTask{id: $id, content: $content, isCompleted: $isCompleted, createdAt: $createdAt}';
//   }

//   SubTaskEntity toEntity() {
//     return SubTaskEntity(id, content, isCompleted, createdAt);
//   }

//   static SubTask fromEntity(SubTaskEntity entity) {
//     return SubTask(
//         id: entity.id,
//         content: entity.content,
//         isCompleted: entity.isCompleted ?? false,
//         createdAt: entity.createdAt ?? DateTime.now());
//   }
// }
