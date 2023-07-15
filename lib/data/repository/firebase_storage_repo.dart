import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repository/i_firebase_storage_repo.dart';

class FirebaseStorageRepo extends IFirebaseStorageRepo {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Future<UploadTask> uploadFile(var audioFile, String fileName) async{
    Reference reference = firebaseStorage.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(audioFile);
    return uploadTask;
  }
}
