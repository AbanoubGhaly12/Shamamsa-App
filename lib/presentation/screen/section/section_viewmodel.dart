import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/usecase/department_usecase.dart';
import 'package:shamamsa_app/domain/usecase/section_usecase.dart';

import '../../base/base_viewmodel.dart';

class SectionViewModel extends BaseViewModel
    with DemoViewModelInputs, DemoViewModelOutputs {
  final SectionUseCase _sectionUseCase;

  SectionViewModel(this._sectionUseCase);

  @override
  void onDispose() {}

  Future setCollection({
    required bool odasCheckBox,
    required bool tasbehaCheckBox,
    required bool egtmaaCheckBox,
    required String collectionId,
    required String documentId,
  }) async {
    await runSafe(() async {
      if (odasCheckBox) {
        await _sectionUseCase.setCollection(
            collectionId: collectionId,
            documentId: documentId,
            documentType: DocumentType.ODAS);
      }
      if (tasbehaCheckBox) {
        await _sectionUseCase.setCollection(
            collectionId: collectionId,
            documentId: documentId,
            documentType: DocumentType.TASBEHA);
      }
      if (egtmaaCheckBox) {
        await _sectionUseCase.setCollection(
            collectionId: collectionId,
            documentId: documentId,
            documentType: DocumentType.EGTMAA);
      }
    });
  }

//
// @override
// Future<List<QueryDocumentSnapshot>> getDocs() async {
//   return await _getDocs();
// }
}

abstract class DemoViewModelInputs {}

abstract class DemoViewModelOutputs {
  // Future<List<QueryDocumentSnapshot>> getDocs();
}
