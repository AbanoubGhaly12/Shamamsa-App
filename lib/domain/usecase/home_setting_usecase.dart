
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/base/base_use_case.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/repository/i_firestore_repo.dart';
import '../entity/login_entity.dart';
import '../repository/i_auth_repo.dart';


class HomeSettingUseCase extends BaseUseCase<void, void> {
  final IFirestoreRepo _firestoreRepo;

  HomeSettingUseCase(this._firestoreRepo);

  @override
  Future execute(input) async {
     await _firestoreRepo.getDocs(collectionId: '');
  }

  Future setDocuments(
      {required String collectionId,
        required String documentId,}) async {
    await _firestoreRepo.createDocument(
        collectionId: collectionId,
        documentId: documentId,
        );
  }
}
