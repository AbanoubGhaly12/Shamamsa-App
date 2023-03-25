import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/common/resources/assets_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';

import '../../../domain/entity/login_entity.dart';
import '../../../domain/usecase/home_setting_usecase.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_viewmodel.dart';

class HomeSettingViewModel extends BaseViewModel with HomeSettingViewModelInputs, HomeSettingViewModelOutputs {
  final HomeSettingUseCase _HomeSettingUseCase;

  HomeSettingViewModel(this._HomeSettingUseCase);

  @override
  void onDispose() {}

  @override
  Future setDocuments({required String collectionId, required String documentId}) async {
    // TODO: implement setDocuments
    await runSafe(() async {
      await _HomeSettingUseCase.setDocuments(collectionId: collectionId, documentId: documentId);
    });
  }
}

abstract class HomeSettingViewModelInputs {}

abstract class HomeSettingViewModelOutputs {
  Future setDocuments({
    required String collectionId,
    required String documentId,
  });
// Future<List<QueryDocumentSnapshot>> getDocs();
}
