import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/enums/document_type.dart';

abstract class IFirestoreRepo {
  Future createCollection({required String collectionId, required String documentId, required DocumentType documentType});

  Future setDocumentField({
    required String collectionId,
    required String name,
    required String examId,
    required int examScore,
  });
  Future setDocumentMap({required String collectionId, required String name, required Map<String,dynamic> map});
  Future deleteCollection({required String collectionId, required String documentId, required DocumentType documentType});

  Future createDocument({required String collectionId, required String documentId});

  Future<QuerySnapshot> getDocuments(String groupChatId, int limit);

  Future<List<QueryDocumentSnapshot>> getCollectionsWithType({required String collectionId, required String documentId, required String typeId});

  Future<List<QueryDocumentSnapshot>> getCollections({required String collectionId, required String documentId});

  Future<List<QueryDocumentSnapshot>> getDocs({required String collectionId});

  Future<DocumentSnapshot?> getDocumentData({required String collectionId, required String name});
}
