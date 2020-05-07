import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/models.dart';

abstract class UserRepository {
  Future<FirebaseUser> signInWithGoogle();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<void> signInWithCredentials(String email, String password);

  Future<void> signUp({String email, String password});

  Future<String> get currentUser;

  Future<String> get currentUserId;

  Future<UserAdditionalInfo> fetchUserAdditionalInfo(String userId);

  Future<void> addCurrentUserAdditionalInfo(UserAdditionalInfo userAdditionalInfo);

  Future<void> updateCurrentUserAdditionalInfo({
        String id,
        String fullName,
        String email,
        String phone,
        String imageUrl,
        String location,
        String about,
        DateTime joinedDate}
      );

  GoogleSignIn get googleSignIn;
}
