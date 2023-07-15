import 'package:firebase_storage/firebase_storage.dart';

abstract class IFirebaseStorageRepo{
  Future<UploadTask> uploadFile(var audioFile, String fileName) ;
}