import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserAdditionalInfoEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String imageUrl;
  final String location;
  final String about;
  final DateTime joinedDate;

  UserAdditionalInfoEntity(this.id, this.fullName, this.email, this.phone,
      this.imageUrl, this.location, this.about, this.joinedDate);

  Map<String, Object> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "imageUrl": imageUrl,
      "location": location,
      "about": about,
      "joinedDate": joinedDate
    };
  }

  @override
  String toString() {
    return 'TaskEntity{id: $id, fullName: $fullName, email: $email, phone: $phone, '
        'imageUrl: $imageUrl, location: $location, about: $about, joinedDate: $joinedDate}';
  }

  static UserAdditionalInfoEntity fromJson(Map<String, Object> json) {
    return UserAdditionalInfoEntity(
      json["id"] as String,
      json["fullName"] as String,
      json["email"] as String,
      json["phone"] as String,
      json["imageUrl"] as String,
      json["location"] as String,
      json["about"] as String,
      DateTime.fromMillisecondsSinceEpoch(
          (json["joinedDate"] as Timestamp).millisecondsSinceEpoch),
    );
  }

  static UserAdditionalInfoEntity fromSnapshot(DocumentSnapshot snap) {
    return UserAdditionalInfoEntity(
      snap.documentID,
      snap.data['fullName'],
      snap.data['email'],
      snap.data['phone'],
      snap.data['imageUrl'],
      snap.data['location'],
      snap.data['about'],
      DateTime.fromMillisecondsSinceEpoch(
          snap.data['joinedDate'].millisecondsSinceEpoch),
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "fullName": fullName,
      "email": email,
      "phone": phone,
      "imageUrl": imageUrl,
      "location": location,
      "about": about,
      "joinedDate": joinedDate
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => null;
}
