import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'entities/entities.dart';
import 'models/models.dart';
import 'user_repository_contract.dart';

class FirebaseUserRepository implements UserRepository {
  final userCollection = Firestore.instance.collection('users');
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  FirebaseUserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return await _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<List<void>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> get currentUser async {
    return (await _firebaseAuth.currentUser()).email;
  }

  Future<String> get currentUserId async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  Future<UserAdditionalInfo> fetchUserAdditionalInfo(String userId) async {
    var document = await userCollection.document(userId).get();
    return UserAdditionalInfo.fromEntity(
        UserAdditionalInfoEntity.fromSnapshot(document));
  }

  Future<void> addCurrentUserAdditionalInfo(
      UserAdditionalInfo userAdditionalInfo) async {
    return await userCollection
        .document(userAdditionalInfo.id)
        .setData(userAdditionalInfo.toEntity().toDocument());
  }

  Future<void> updateCurrentUserAdditionalInfo(
      {String id,
      String fullName,
      String email,
      String phone,
      String imageUrl,
      String location,
      String about,
      DateTime joinedDate}) async {
    var currentUserAdditionalInfo =
        await fetchUserAdditionalInfo(await currentUserId);
    return await userCollection
        .document((await _firebaseAuth.currentUser()).uid)
        .updateData(UserAdditionalInfo(
                id: id ?? currentUserAdditionalInfo.id,
                fullName: fullName ?? currentUserAdditionalInfo.fullName,
                email: email ?? currentUserAdditionalInfo.email,
                phone: phone ?? currentUserAdditionalInfo.phone,
                imageUrl: imageUrl ?? currentUserAdditionalInfo.imageUrl,
                location: location ?? currentUserAdditionalInfo.location,
                about: about ?? currentUserAdditionalInfo.about,
                joinedDate: joinedDate ?? currentUserAdditionalInfo.joinedDate)
            .toEntity()
            .toDocument());
  }

  Future<void> deleteCurrentUserAdditionalInfo() async {
    return await userCollection.document(await currentUserId).delete();
  }

  get googleSignIn => _googleSignIn;
}
