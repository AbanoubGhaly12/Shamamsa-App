import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/domain/usecase/exam_usecase.dart';
import 'package:shamamsa_app/presentation/base/base_viewmodel.dart';

class ExamViewModel extends BaseViewModel with ExamViewModelInputs, ExamViewModelOutputs {
  final ExamUseCase _examUseCase;

  ExamViewModel(this._examUseCase);

  List<String> names = [];
  Map<String,double> scoreValidation = {};


  final StreamController<List<QueryDocumentSnapshot>> _examStreamController = BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<Map<String, dynamic>> _resultsStreamController = BehaviorSubject<Map<String, dynamic>>();

  @override
  void onDispose() {
    _examStreamController.close();
  }

  @override
  Future getExamDetails({required String collectionId}) async {
    await runSafe(() async {
      await _examUseCase.getCollection(collectionId: collectionId).then((value) async{
        examDetailsSink.add(value);
      });
    });
  }

  @override
  Sink get examDetailsSink => _examStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get examDetailsStream => _examStreamController.stream;

  @override
  Future submitValue({
    required String collectionId,
    required String name,
    required String examId,
    required int examScore,
  }) async {
    await runSafe(() async {
      await _examUseCase.setDocumentField(collectionId: collectionId, name: name, examId: examId, examScore: examScore);
    });
  }

  @override
  Future submitMap({required String collectionId, required String name, required Map<String, dynamic> map}) async {
    await runSafe(() async {
      await _examUseCase.setDocumentMap(collectionId: collectionId, name: name, map: map);
    });
  }

  @override
  Future findScoreById({required String collectionId, required String name}) async {
    await runSafe(() async {
      var data = await _examUseCase.getResults(collectionId: collectionId, name: name);
      resultSink.add(data);
    });
  }

  @override
  Sink get resultSink => _resultsStreamController.sink;

  @override
  Stream<Map<String, dynamic>> get resultsStream => _resultsStreamController.stream;
}

abstract class ExamViewModelInputs {
  Stream<List<QueryDocumentSnapshot>> get examDetailsStream;

  Stream<Map<String, dynamic>> get resultsStream;
}

abstract class ExamViewModelOutputs {
  Future getExamDetails({required String collectionId});

  Future submitValue({
    required String collectionId,
    required String name,
    required String examId,
    required int examScore,
  });

  Future findScoreById({
    required String collectionId,
    required String name,
  });

  Sink get examDetailsSink;

  Sink get resultSink;
}
