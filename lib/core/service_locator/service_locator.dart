import 'package:core/managers/storage/providers/i_storage_provider.dart';
import 'package:core/managers/storage/providers/local_storage_provider.dart';
import 'package:core/models/app_settings.dart';
import 'package:core/service_locator/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shamamsa_app/data/repository/firestore_repo.dart';
import 'package:shamamsa_app/domain/repository/i_firestore_repo.dart';
import 'package:shamamsa_app/domain/usecase/department_usecase.dart';
import 'package:shamamsa_app/domain/usecase/exam_usecase.dart';
import 'package:shamamsa_app/domain/usecase/home_setting_usecase.dart';
import 'package:shamamsa_app/domain/usecase/section_usecase.dart';
import 'package:shamamsa_app/presentation/screen/department/department_viewmodel.dart';
import 'package:shamamsa_app/presentation/screen/exam/exam_viewmodel.dart';
import 'package:shamamsa_app/presentation/screen/home_setting/home_setting_viewmodel.dart';
import 'package:shamamsa_app/presentation/screen/section/section_viewmodel.dart';

import '../../data/repository/auth_repo.dart';
import '../../domain/repository/i_auth_repo.dart';
import '../../domain/usecase/details_usecase.dart';
import '../../domain/usecase/login_usecase.dart';
import '../../presentation/screen/details/details_viewmodel.dart';
import '../../presentation/screen/login/login_viewmodel.dart';
import '../setting/setting.dart';
import 'package:get_it/get_it.dart';

initAppModule() async {
  getInstance.registerLazySingleton<AppSettings>(() => Setting());
  getInstance.registerLazySingleton<IStorageProvider>(() => LocalStorageProvider());

  initAppModuleBase();
}

initRepos() {
  getInstance.registerLazySingleton<IAuthRepo>(() => AuthRepo());
  getInstance.registerLazySingleton<IFirestoreRepo>(() => FirestoreRepo());
}

initLoginViewModel() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    getInstance.registerFactory<LoginUseCase>(() => LoginUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<LoginViewModel>()) {
    getInstance.registerFactory<LoginViewModel>(() => LoginViewModel(getInstance()));
  }
}

initDepartmentViewModel() {
  // if (!GetIt.I.isRegistered<DepartmentUseCase>()) {
  //   getInstance.registerFactory<DepartmentUseCase>(() => DepartmentUseCase(getInstance()));
  // }
  if (!GetIt.I.isRegistered<DepartmentViewModel>()) {
    getInstance.registerFactory<DepartmentViewModel>(() => DepartmentViewModel());
  }
}

initDetailsViewModel() {
  if (!GetIt.I.isRegistered<DetailsUseCase>()) {
    getInstance.registerFactory<DetailsUseCase>(() => DetailsUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<SectionUseCase>()) {
    getInstance.registerFactory<SectionUseCase>(() => SectionUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<ExamUseCase>()) {
    getInstance.registerFactory<ExamUseCase>(() => ExamUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<DetailsViewModel>()) {
    getInstance.registerFactory<DetailsViewModel>(() => DetailsViewModel(getInstance(), getInstance(), getInstance()));
  }
}

initExamViewModel() {
  if (!GetIt.I.isRegistered<ExamUseCase>()) {
    getInstance.registerFactory<ExamUseCase>(() => ExamUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<ExamViewModel>()) {
    getInstance.registerFactory<ExamViewModel>(() => ExamViewModel(getInstance()));
  }
}

initHomeSettingViewModel() {
  if (!GetIt.I.isRegistered<HomeSettingUseCase>()) {
    getInstance.registerFactory<HomeSettingUseCase>(() => HomeSettingUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<HomeSettingViewModel>()) {
    getInstance.registerFactory<HomeSettingViewModel>(() => HomeSettingViewModel(getInstance()));
  }
}

initSectionViewModel() {
  if (!GetIt.I.isRegistered<SectionUseCase>()) {
    getInstance.registerFactory<SectionUseCase>(() => SectionUseCase(getInstance()));
  }
  if (!GetIt.I.isRegistered<SectionViewModel>()) {
    getInstance.registerFactory<SectionViewModel>(() => SectionViewModel(getInstance()));
  }
}
