import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/common/resources/assets_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/data/repository/firebase_storage_repo.dart';
import 'package:shamamsa_app/domain/usecase/details_usecase.dart';
import 'package:shamamsa_app/domain/usecase/exam_usecase.dart';

import '../../../common/enums/document_type.dart';
import '../../../domain/entity/login_entity.dart';
import '../../../domain/repository/i_firebase_storage_repo.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../../domain/usecase/section_usecase.dart';
import '../../base/base_viewmodel.dart';

class DetailsViewModel extends BaseViewModel with DetailsViewModelInputs, DetailsViewModelOutputs {
  final DetailsUseCase _detailsUseCase;
  final ExamUseCase _examUseCase;
  final SectionUseCase _sectionUseCase;
  IFirebaseStorageRepo firebaseStorageRepo = FirebaseStorageRepo();

  DetailsViewModel(this._detailsUseCase, this._sectionUseCase, this._examUseCase);

  List<String> names = [];

  List<Future> attendanceFutures = [];
  // List<int> sundayLitrugy = [];
  // List<int> fridayLitrugy = [];
  // List<int> eve = [];
  // List<int> classAttendance = [];
  List<Map<String, dynamic>> toCsvMap = [];
  List<Map<String, dynamic>> examScore = [];
  final StreamController<List<QueryDocumentSnapshot>> _dataStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _odasStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _tasbehaStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _egtmaaStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();

  @override
  void onDispose() {
    _dataStreamController.close();
    _odasStreamController.close();
    _tasbehaStreamController.close();
    _egtmaaStreamController.close();
  }

  @override
  Future getAllDocuments({required String collectionId}) async {
    await runSafe(() async {
      await _detailsUseCase.execute(collectionId).then((value) {
        dataSink.add(value);
        for (int i = 0; i < value.length; i++) {
          names.add(value[i].id);
        }
      });
    });
  }

  @override
  Future getAttendance({required String collectionId, required String documentId}) async {
    // TODO: implement getAttendance
    await runSafe(() async {
      // await _detailsUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.EGTMAA).then((value) => egtmaaSink.add(value));
      // await _detailsUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.TASBEHA).then((value) => tasbehaSink.add(value));
      // await _detailsUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.ODAS).then((value) => odasSink.add(value));
    });
  }

  @override
  Future getAttendanceForAllStudents({required String collectionId}) async {
    await runSafe(() async {
      for (int i = 0; i < names.length; i++) {
        attendanceFutures.add(getStudentAttendance(collectionId: collectionId, name: names[i]));
      }
      await Future.wait(attendanceFutures);
      String csv = jsonToCsv(toCsvMap);
      print(csv);
      await exportCsv(csv, "$collectionId attendance + ${DateTime.now().toString()}");
      view?.showSuccessMsg('تم رفع البيانات بنجاح');
    });
  }

  Future getStudentAttendance({required String collectionId, required String name}) async {
    await runSafe(() async {
      int sundayLitrugy = 0;
      int fridayLitrugy = 0;
      int eve = 0;
      int classAttendance = 0;
      await _detailsUseCase.getCollection(collectionId: collectionId, documentId: name, documentType: DocumentType.sundayLitrugy).then((value) {
        sundayLitrugy = value.length;
      });
      await _detailsUseCase.getCollection(collectionId: collectionId, documentId: name, documentType: DocumentType.fridayLitrugy).then((value) {
        fridayLitrugy = value.length;
      });
      await _detailsUseCase.getCollection(collectionId: collectionId, documentId: name, documentType: DocumentType.eve).then((value) {
        eve = value.length;
      });

      await _detailsUseCase.getCollection(collectionId: collectionId, documentId: name, documentType: DocumentType.classAttendance).then((value) {
        classAttendance = value.length;
      });
      toCsvMap.add({
        'الاسم': name,
        "حضور الحصة": classAttendance,
        'حضور قداس الاحد': sundayLitrugy,
        'حضور القداسات': fridayLitrugy,
        'حضور العشية': eve,
      });
      print(toCsvMap.last);
    });
  }

  @override
  Future getExamScoreCsv({required String collectionId}) async {
    await runSafe(() async {
      for (String name in names) {
        Map<String, dynamic>? examScoreMap = await _examUseCase.getResults(collectionId: collectionId, name: name);
        Map<String, dynamic> mapEntry = {
          "الاسم": name,
          "مرد انجيل القيامه": examScoreMap?["مرد انجيل القيامه"],
          "اوشيه المرضي": examScoreMap?["اوشيه المرضي"],
          "مرد ابركسيس الصعود": examScoreMap?["مرد ابركسيس الصعود"],
          "مرد مزمور الصعود": examScoreMap?["مرد مزمور الصعود"],
          "مرد ابركسيس الصوم الكبير": examScoreMap?["مرد ابركسيس الصوم الكبير"],
          "نيف سنتي": examScoreMap?["نيف سنتي"],
          "الليلويا اي اي ابخون": examScoreMap?["الليلويا اي اي ابخون"],
          "هيتنيات القيامه": examScoreMap?["هيتنيات القيامه"],
          "بي نيشتي": examScoreMap?["بي نيشتي"],
          "لبش الهوس الثاني": examScoreMap?["لبش الهوس الثاني"],
          " اي كوتي ": examScoreMap?[" اي كوتي "],
          "مرد انجيل الصعود": examScoreMap?["مرد انجيل الصعود"],
          "مرد مزمور القيامه": examScoreMap?["مرد مزمور القيامه"],
          "اوشيه المسافرين": examScoreMap?["اوشيه المسافرين"],
          "Bouns": examScoreMap?["Bouns"],
          "قبطي": examScoreMap?["قبطي"],
          "دراسات": examScoreMap?["دراسات"],
        };
        double copticScore = mapEntry["قبطي"] / 2;
        double studyScore = mapEntry["دراسات"] / 2;
        if (copticScore > 50) {
          mapEntry["Bouns"] += (copticScore - 50);
          copticScore = 50;
        }
        if (studyScore > 50) {
          mapEntry["Bouns"] += (studyScore - 50);
          studyScore = 50;
        }
        mapEntry["قبطي"] = copticScore;
        mapEntry["دراسات"] = studyScore;

        double total = 0;
        mapEntry.forEach((key, value) {
          if (key != "الاسم") {
            total += value;
          }
        });
        mapEntry["المجموع الكلي"] = total;
        examScore.add(mapEntry);
      }
      String csv = jsonToCsv(examScore);
      await exportCsv(csv, "exam-score");
      view?.showSuccessMsg('تم رفع البيانات بنجاح');
    });
  }

  String jsonToCsv(List<Map<String, dynamic>> jsonList) {
    List<List<dynamic>> csvData = [];
    csvData.add(jsonList[0].keys.toList()); // add headers
    for (var i = 0; i < jsonList.length; i++) {
      List<dynamic> row = [];
      jsonList[i].forEach((key, value) => row.add(value));
      csvData.add(row);
    }
    return const ListToCsvConverter().convert(csvData);
  }

  Future<void> exportCsv(String csvData, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$fileName.csv');
    await file.writeAsString(csvData);
    if (file == null) return;
    await firebaseStorageRepo.uploadFile(file, "$fileName.csv");
  }

  @override
  Sink get dataSink => _dataStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get dataStream => _dataStreamController.stream;

  @override
  Sink get egtmaaSink => _egtmaaStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get egtmaaStream => _egtmaaStreamController.stream;

  @override
  Sink get odasSink => _odasStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get odasStream => _odasStreamController.stream;

  @override
  Sink get tasbehaSink => _tasbehaStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get tasbehaStream => _tasbehaStreamController.stream;

// Future setCollection({
//   required DocumentType documentType,
//   required String collectionId,
//   required String documentId,
// }) async {
//   await runSafe(() async {
//     await _sectionUseCase.setCollection(collectionId: collectionId, documentId: documentId, documentType: documentType);
//   });
// }

// Future removeCollection({
//   required DocumentType documentType,
//   required String collectionId,
//   required String documentId,
// }) async {
//   await runSafe(() async {
//     await _sectionUseCase.setCollection(collectionId: collectionId, documentId: documentId, documentType: documentType);
//   });
// }
}

abstract class DetailsViewModelInputs {
  Stream<List<QueryDocumentSnapshot>> get dataStream;

  Stream<List<QueryDocumentSnapshot>> get odasStream;

  Stream<List<QueryDocumentSnapshot>> get tasbehaStream;

  Stream<List<QueryDocumentSnapshot>> get egtmaaStream;
}

abstract class DetailsViewModelOutputs {
  Future getAllDocuments({required String collectionId});

  Future getAttendance({required String collectionId, required String documentId});

  Future getAttendanceForAllStudents({required String collectionId});

  Future getExamScoreCsv({required String collectionId});

  Sink get dataSink;

  Sink get odasSink;

  Sink get egtmaaSink;

  Sink get tasbehaSink;
}
