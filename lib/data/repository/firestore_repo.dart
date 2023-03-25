import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/repository/i_firestore_repo.dart';

class FirestoreRepo extends IFirestoreRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future createCollection({required String collectionId, required String documentId, required DocumentType documentType}) async {
    CollectionReference collectionReference = firebaseFirestore.collection(collectionId).doc(documentId).collection(documentType.getValue());

    await collectionReference.doc(DateTime.now().toString()).set({"time": DateTime.now().toString()});
  }

  @override
  Future createDocument({
    required String collectionId,
    required String documentId,
  }) async {
    await firebaseFirestore.collection(collectionId).doc(documentId).set({});
  }

  @override
  Future<List<QueryDocumentSnapshot>> getCollections({required String collectionId, required String documentId, required String typeId}) async {
    var querySnapshot = await firebaseFirestore.collection(collectionId).doc(documentId).collection(typeId).get();
    return querySnapshot.docs;
  }

  @override
  Future<QuerySnapshot<Object?>> getDocuments(String groupChatId, int limit) {
    // TODO: implement getDocuments
    throw UnimplementedError();
  }

  @override
  Future<List<QueryDocumentSnapshot>> getDocs({required String collectionId}) async {
    QuerySnapshot querySnapshot = await firebaseFirestore.collection(collectionId).get();
    return querySnapshot.docs;
  }
}
