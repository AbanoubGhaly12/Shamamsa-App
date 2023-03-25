import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/enums/document_type.dart';

abstract class IFirestoreRepo {
  Future createCollection({required String collectionId, required String documentId, required DocumentType documentType});

  Future createDocument({required String collectionId, required String documentId});

  Future<QuerySnapshot> getDocuments(String groupChatId, int limit);

  Future<List<QueryDocumentSnapshot>> getCollections({required String collectionId, required String documentId, required String typeId});

  Future<List<QueryDocumentSnapshot>> getDocs({required String collectionId});
}
