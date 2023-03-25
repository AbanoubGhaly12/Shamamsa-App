import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shamamsa_app/common/resources/assets_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/domain/usecase/details_usecase.dart';

import '../../../common/enums/document_type.dart';
import '../../../domain/entity/login_entity.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_viewmodel.dart';

class DetailsViewModel extends BaseViewModel
    with DetailsViewModelInputs, DetailsViewModelOutputs {
  final DetailsUseCase _detailsUseCase;

  DetailsViewModel(this._detailsUseCase);

  final StreamController<List<QueryDocumentSnapshot>> _dataStreamController =
      BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _odasStreamController =
      BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _tasbehaStreamController =
      BehaviorSubject<List<QueryDocumentSnapshot>>();
  final StreamController<List<QueryDocumentSnapshot>> _egtmaaStreamController =
      BehaviorSubject<List<QueryDocumentSnapshot>>();

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
      await _detailsUseCase
          .execute(collectionId)
          .then((value) => dataSink.add(value));
    });
  }
  @override
  Future getAttendance({required String collectionId, required String documentId}) async{
    // TODO: implement getAttendance
    await runSafe(() async {
      await _detailsUseCase
          .getCollection(collectionId: collectionId,documentId: documentId,documentType:DocumentType.EGTMAA)
          .then((value) => egtmaaSink.add(value));
      await _detailsUseCase
          .getCollection(collectionId: collectionId,documentId: documentId,documentType:DocumentType.TASBEHA)
          .then((value) => tasbehaSink.add(value));
      await _detailsUseCase
          .getCollection(collectionId: collectionId,documentId: documentId,documentType:DocumentType.ODAS)
          .then((value) => odasSink.add(value));

    });  }
  @override
  Sink get dataSink => _dataStreamController.sink;

  @override
  Stream<List<QueryDocumentSnapshot<Object?>>> get dataStream =>
      _dataStreamController.stream;

  @override
  // TODO: implement egtmaaSink
  Sink get egtmaaSink => _egtmaaStreamController.sink;

  @override
  // TODO: implement egtmaaStream
  Stream<List<QueryDocumentSnapshot<Object?>>> get egtmaaStream => _egtmaaStreamController.stream;

  @override
  // TODO: implement odasSink
  Sink get odasSink => _odasStreamController.sink;

  @override
  // TODO: implement odasStream
  Stream<List<QueryDocumentSnapshot<Object?>>> get odasStream => _odasStreamController.stream;

  @override
  // TODO: implement tasbehaSink
  Sink get tasbehaSink => _tasbehaStreamController.sink;

  @override
  // TODO: implement tasbehaStream
  Stream<List<QueryDocumentSnapshot<Object?>>> get tasbehaStream => _tasbehaStreamController.stream;


}

abstract class DetailsViewModelInputs {
  Stream<List<QueryDocumentSnapshot>> get dataStream;

  Stream<List<QueryDocumentSnapshot>> get odasStream;

  Stream<List<QueryDocumentSnapshot>> get tasbehaStream;

  Stream<List<QueryDocumentSnapshot>> get egtmaaStream;
}

abstract class DetailsViewModelOutputs {
  Future getAllDocuments({required String collectionId});
  Future getAttendance({required String collectionId,required String documentId});

  Sink get dataSink;

  Sink get odasSink;

  Sink get egtmaaSink;

  Sink get tasbehaSink;
}
