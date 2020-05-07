import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import 'storage_file_repository.dart';

class FirebaseStorageFileRepository implements StorageFileRepository {
  FirebaseStorage storage =
      FirebaseStorage(storageBucket: 'gs://perfectly-9b4ab.appspot.com');
  final Directory systemTempDir = Directory.systemTemp;

  bool _isUserLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> uploadFile(String sourcePath,
      {StorageMetadata storageMetadata, String storageFolderPath = ''}) async {
    var url;
    if (_isUserLoggedIn()) {
      var uuid = Uuid();
      StorageReference ref;

      try {
        String completeFileName =
            '$storageFolderPath${uuid.v1()}${p.extension(sourcePath)}';
        ref = storage.ref().child(completeFileName);
        StorageUploadTask uploadTask =
            ref.putFile(File(sourcePath), storageMetadata);
        url = await (await uploadTask.onComplete).ref.getDownloadURL();
      } catch (_) {
        rethrow;
      }
    }
    return url.toString();
  }

  @override
  Future<bool> deleteFile(String url) async {
    try {
      var ref = await storage.getReferenceFromUrl(url);
      await ref.delete();
    } catch (_) {
      return false;
    }
    return true;
  }
}
