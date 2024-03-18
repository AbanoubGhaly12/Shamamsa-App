import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/base/base_use_case.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/repository/i_firestore_repo.dart';
import '../entity/login_entity.dart';
import '../repository/i_auth_repo.dart';

class SectionUseCase extends BaseUseCase<void, List<QueryDocumentSnapshot>> {
  final IFirestoreRepo _firestoreRepo;

  SectionUseCase(this._firestoreRepo);

  @override
  Future<List<QueryDocumentSnapshot>> execute(input) async {
    return await _firestoreRepo.getDocs(collectionId: '');
  }

  Future setCollection({required String collectionId, required String documentId, required String documentType}) async {
    await _firestoreRepo.createCollection(collectionId: collectionId, documentId: documentId, documentType: documentType);
  }

  Future removeCollection({required String collectionId, required String documentId, required String documentType}) async {
    await _firestoreRepo.createCollection(collectionId: collectionId, documentId: documentId, documentType: documentType);
  }

  Future<DocumentSnapshot?> checkExistence({required String collectionId, required String documentId}) async {
    return await _firestoreRepo.getDocumentData(collectionId: collectionId, name: documentId);
  }

  Future<List<QueryDocumentSnapshot>> getCollection({required String collectionId, required String documentId, required DocumentType documentType}) async {
    return await _firestoreRepo.getCollectionsWithType(collectionId: collectionId, documentId: documentId, typeId: documentType.value);
  }
}
