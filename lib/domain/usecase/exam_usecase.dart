import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/base/base_use_case.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/repository/i_firestore_repo.dart';
import '../entity/login_entity.dart';
import '../repository/i_auth_repo.dart';

class ExamUseCase extends BaseUseCase<void, List<QueryDocumentSnapshot>> {
  final IFirestoreRepo _firestoreRepo;

  ExamUseCase(this._firestoreRepo);

  @override
  Future<List<QueryDocumentSnapshot>> execute(input) async {
    return await _firestoreRepo.getDocs(collectionId: '');
  }

  Future setDocumentField({
    required String collectionId,
    required String name,
    required String examId,
    required int examScore,
  }) async {
    await _firestoreRepo.setDocumentField(collectionId: collectionId, name: name, examId: examId, examScore: examScore);
  }
  Future setDocumentMap({
    required String collectionId,
    required String name,
    required Map<String,dynamic> map
  }) async {
    await _firestoreRepo.setDocumentMap(collectionId: collectionId, name: name,map: map);
  }

  Future removeCollection({required String collectionId, required String documentId, required DocumentType documentType}) async {
    await _firestoreRepo.createCollection(collectionId: collectionId, documentId: documentId, documentType: documentType);
  }

  Future<List<QueryDocumentSnapshot>> getCollection({required String collectionId}) async {
    return await _firestoreRepo.getDocs(
      collectionId: collectionId,
    );
  }

  Future<Map<String, dynamic>?> getResults({required String collectionId, required String name}) async {
    Map<String, dynamic> data = {};
    await _firestoreRepo
        .getDocumentData(
      collectionId: collectionId,
      name: name,
    )
        .then((value) {
      data = value?.data() as Map<String, dynamic>? ??{};
    });
    return data;
  }
}
