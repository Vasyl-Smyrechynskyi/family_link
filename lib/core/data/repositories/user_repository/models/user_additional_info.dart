import '../entities/entities.dart';

class UserAdditionalInfo {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String imageUrl;
  final String location;
  final String about;
  final DateTime joinedDate;

  UserAdditionalInfo(
      {String id,
      String fullName,
      String email,
      String phone,
      this.imageUrl,
      String location,
      String about,
      this.joinedDate})
      : this.id = id,
        this.fullName = fullName ?? '',
        this.email = email ?? '',
        this.phone = phone ?? '',
        this.location = location ?? '',
        this.about = about ?? '';

  UserAdditionalInfo copyWith({
    String id,
    String fullName,
    String email,
    String phone,
    String imageUrl,
    String location,
    String about,
    DateTime joinedDate,
  }) {
    return UserAdditionalInfo(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        imageUrl: imageUrl ?? this.imageUrl,
        location: location ?? this.location,
        about: about ?? this.about,
        joinedDate: joinedDate ?? this.joinedDate);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      fullName.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      imageUrl.hashCode ^
      location.hashCode ^
      about.hashCode ^
      joinedDate.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdditionalInfo &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fullName == other.fullName &&
          email == other.email &&
          phone == other.phone &&
          imageUrl == other.imageUrl &&
          location == other.location &&
          about == other.about &&
          joinedDate == other.joinedDate;

  @override
  String toString() {
    return 'Task{id: $id, fullName: $fullName, email: $email, phone: $phone, '
        'imageUrl: $imageUrl, location: $location, about: $about, joinedDate: $joinedDate}';
  }

  UserAdditionalInfoEntity toEntity() {
    return UserAdditionalInfoEntity(
        id, fullName, email, phone, imageUrl, location, about, joinedDate);
  }

  static UserAdditionalInfo fromEntity(UserAdditionalInfoEntity entity) {
    return UserAdditionalInfo(
        id: entity.id,
        fullName: entity.fullName,
        email: entity.email,
        phone: entity.phone,
        imageUrl: entity.imageUrl,
        location: entity.location,
        about: entity.about,
        joinedDate: entity.joinedDate);
  }
}
