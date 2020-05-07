import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../core/data/repositories/storage_file_repository/storage_file_repository.dart';

class FileService {
  final FirebaseStorageFileRepository firebaseStorageFileRepository =
      FirebaseStorageFileRepository();

  Future<String> fetchFile(String url) async {
    File file;
    try {
      file = await DefaultCacheManager().getSingleFile(url);
    } catch (_) {
      rethrow;
    }
    return file.path;
  }

  Future<FileInfo> fetchFileInfo(String url) async {
    FileInfo fileInfo;
    try {
      fileInfo = await DefaultCacheManager().getFile(url).first;
    } catch (_) {
      rethrow;
    }
    return fileInfo;
  }

  Future<String> saveFile(String path,
      {StorageMetadata storageMetadata, String storageFolderPath = ''}) async {
    var url = await firebaseStorageFileRepository.uploadFile(path,
        storageMetadata: storageMetadata, storageFolderPath: storageFolderPath);
    var fileBytes = File(path).readAsBytesSync();
    await DefaultCacheManager().putFile(url, fileBytes);

    return url;
  }

  deleteFile(String url) async {
    if (url == null) return;

    await DefaultCacheManager().removeFile(url);
    await firebaseStorageFileRepository.deleteFile(url);
  }
}
