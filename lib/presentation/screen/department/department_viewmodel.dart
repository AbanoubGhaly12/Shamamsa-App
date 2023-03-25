import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/common/resources/assets_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/domain/usecase/department_usecase.dart';

import '../../../domain/entity/login_entity.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_viewmodel.dart';

class DepartmentViewModel extends BaseViewModel
    with DemoViewModelInputs, DemoViewModelOutputs {
  // final DepartmentUseCase _departmentUseCase;
  //
  // DepartmentViewModel(this._departmentUseCase);

  List<Map<String, String>> items = [
    {
      "name": TextManager.saintAbanoub.tr(),
      "image": ImageAssetsManager.abanoub
    },
    {
      "name": TextManager.deskoros.tr(),
      "image": ImageAssetsManager.deskoros
    },
    {
      "name": TextManager.sedhomBeshay.tr(),
      "image": ImageAssetsManager.SidhomBishay
    },
    {
      "name": TextManager.esklabios.tr(),
      "image": ImageAssetsManager.deskoros
    },
    {
      "name": TextManager.papaKerolos.tr(),
      "image": ImageAssetsManager.papaKerolos
    },
    {"name": TextManager.ebram.tr(), "image": ImageAssetsManager.ebram},
    {
      "name": TextManager.estifanos.tr(),
      "image": ImageAssetsManager.estefanos
    },
  ];

  List<String> collectionReference = [
    "اسرة القديس ابانوب",
    "اسرة البابا ديسقوروس",
    "اسرة القديس سيدهم بشاي",
    "اسرة القديس اسكلابيوس",
    "اسرة البابا كيرلس",
    "اسرة القديس الانبا ابرام",
    "اسرة القديس استيفانوس",
  ];

  @override
  void onDispose() {}
}

abstract class DemoViewModelInputs {}

abstract class DemoViewModelOutputs {
  // Future<List<QueryDocumentSnapshot>> getDocs();
}
