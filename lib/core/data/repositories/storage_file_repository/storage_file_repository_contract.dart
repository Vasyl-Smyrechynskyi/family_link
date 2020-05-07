import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageFileRepository {
  Future<String> uploadFile(String sourcePath,
      {StorageMetadata storageMetadata, String storageFolderPath});
  Future<bool> deleteFile(String url);
}
