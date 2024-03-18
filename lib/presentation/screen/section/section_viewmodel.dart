import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/domain/usecase/department_usecase.dart';
import 'package:shamamsa_app/domain/usecase/section_usecase.dart';

import '../../base/base_viewmodel.dart';

class SectionViewModel extends BaseViewModel with DemoViewModelInputs, DemoViewModelOutputs {
  final SectionUseCase _sectionUseCase;

  SectionViewModel(this._sectionUseCase);

  final StreamController<List<QueryDocumentSnapshot>?> _classStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _eveStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _fridayLitrugyStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _sundayLitrugyStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<DateTime?> _lastClassStreamController = BehaviorSubject<DateTime?>();
  final StreamController<DateTime?> _lastEveStreamController = BehaviorSubject<DateTime?>();
  final StreamController<DateTime?> _lastFridayLitrugyStreamController = BehaviorSubject<DateTime?>();
  final StreamController<DateTime?> _lastSundayLitrugyStreamController = BehaviorSubject<DateTime?>();

  @override
  Sink get classSink => _classStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot>?> get classStream => _classStreamController.stream;

  @override
  Sink get eveSink => _eveStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot>?> get eveStream => _eveStreamController.stream;

  @override
  Sink get fridayLitrugySink => _fridayLitrugyStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot>?> get fridayLitrugyStream => _fridayLitrugyStreamController.stream;

  @override
  Sink get sundayLitrugySink => _sundayLitrugyStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get sundayLitrugyStream => _sundayLitrugyStreamController.stream;

//

  @override
  void onDispose() {
    _classStreamController.close();
    _eveStreamController.close();
    _fridayLitrugyStreamController.close();
    _sundayLitrugyStreamController.close();
    _lastClassStreamController.close();
    _lastEveStreamController.close();
    _lastFridayLitrugyStreamController.close();
    _lastSundayLitrugyStreamController.close();
  }

  Future setCollection({
    required bool odasCheckBox,
    required String collectionId,
    required String documentId,
    required String day,
  }) async {
    await runSafe(() async {
      var result = await _sectionUseCase.checkExistence(collectionId: collectionId, documentId: documentId);
      if (result != null) {
        await _sectionUseCase.setCollection(collectionId: collectionId, documentId: documentId, documentType: day);
      } else {
        showErrorMessage(message: "هذا الاسم غير موجود بالمرحلة");
      }
    });
  }

  Future getAttendance({required String collectionId, required String documentId}) async {
    await runSafe(() async {
      await _sectionUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.fridayLitrugy).then((value) async {
        fridayLitrugySink.add(value);
        await getNewestDate(value).then((snap) {
          lastFridayLitrugySink.add(snap);
        });
      });
      await _sectionUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.sundayLitrugy).then((value) async {
        sundayLitrugySink.add(value);
        await getNewestDate(value).then((snap) {
          lastSundayLitrugySink.add(snap);
        });
      });
      await _sectionUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.eve).then((value) async {
        eveSink.add(value);
        await getNewestDate(value).then((snap) {
          lastEveSink.add(snap);
        });
      });
      await _sectionUseCase.getCollection(collectionId: collectionId, documentId: documentId, documentType: DocumentType.classAttendance).then((value) async {
        classSink.add(value);
        await getNewestDate(value).then((snap) {
          lastClassSink.add(snap);
        });
      });
    });
  }

  Future<DateTime?> getNewestDate(List<QueryDocumentSnapshot<Object?>>? snapshots) async {
    DateTime? newestDate;

    for (QueryDocumentSnapshot<Object?> snapshot in snapshots ?? []) {
      // Assuming your date field in the document is named "dateField"
      final dateField = snapshot.id;

      final date = DateFormat.yMMMEd().parse(dateField);
      if (newestDate == null || date.isAfter(newestDate)) {
        newestDate = date;
      }
    }
    ;
    return newestDate;
  }

  @override
  // TODO: implement lastClassSink
  Sink get lastClassSink => _lastClassStreamController.sink;

  @override
  // TODO: implement lastClassStream
  Stream<DateTime?> get lastClassStream => _lastClassStreamController.stream;

  @override
  // TODO: implement lastEveSink
  Sink get lastEveSink => _lastEveStreamController.sink;

  @override
  // TODO: implement lastEveStream
  Stream<DateTime?> get lastEveStream => _lastEveStreamController.stream;

  @override
  // TODO: implement lastFridayLitrugySink
  Sink get lastFridayLitrugySink => _lastFridayLitrugyStreamController.sink;

  @override
  // TODO: implement lastFridayLitrugyStream
  Stream<DateTime?> get lastFridayLitrugyStream => _lastFridayLitrugyStreamController.stream;

  @override
  // TODO: implement lastSundayLitrugySink
  Sink get lastSundayLitrugySink => _lastSundayLitrugyStreamController.sink;

  @override
  // TODO: implement lastSundayLitrugyStream
  Stream<DateTime?> get lastSundayLitrugyStream => _lastSundayLitrugyStreamController.stream;

// @override
// Future<List<QueryDocumentSnapshot>> getDocs() async {
//   return await _getDocs();
// }
}

abstract class DemoViewModelInputs {
  Sink get fridayLitrugySink;

  Sink get sundayLitrugySink;

  Sink get eveSink;

  Sink get classSink;

  Sink get lastSundayLitrugySink;

  Sink get lastFridayLitrugySink;

  Sink get lastEveSink;

  Sink get lastClassSink;
}

abstract class DemoViewModelOutputs {
  Stream<List<QueryDocumentSnapshot>?> get fridayLitrugyStream;

  Stream<List<QueryDocumentSnapshot>?> get sundayLitrugyStream;

  Stream<List<QueryDocumentSnapshot>?> get eveStream;

  Stream<List<QueryDocumentSnapshot>?> get classStream;

  Stream<DateTime?> get lastSundayLitrugyStream;

  Stream<DateTime?> get lastFridayLitrugyStream;

  Stream<DateTime?> get lastEveStream;

  Stream<DateTime?> get lastClassStream;
}
