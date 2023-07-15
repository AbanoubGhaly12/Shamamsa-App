import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shamamsa_app/common/widget/custom_button.dart';
import 'package:shamamsa_app/common/widget/exam_widget.dart';
import 'package:shamamsa_app/presentation/base/base_state.dart';

import '../../../common/resources/color_manager.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/resources/style_manager.dart';
import '../../../common/resources/text_manager.dart';
import '../../../common/widget/custom_text.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../model/ExamFormModel.dart';
import 'exam_viewmodel.dart';

class ExamScreen extends StatefulWidget {
  final ExamFormModel examFormModel;

  const ExamScreen({Key? key, required this.examFormModel}) : super(key: key);

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends BaseState<ExamScreen, ExamViewModel> {
  List<ExamUiModel> examUiModels = [];
  int value = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  Map<String, dynamic> map = {};
                  for (var element in examUiModels) {
                    map.addEntries({element.title: int.parse(element.score)}.entries);
                  }
                  await viewModel.submitMap(collectionId: widget.examFormModel.collectionReferenceId, name: widget.examFormModel.docId, map: map);
                  viewModel.navigation.pop();
                }else{
                  viewModel.view?.showErrorMsg("برجاء ادخال البيانات صحيحة");
                }
              },
              icon: const Icon(Icons.save_as_rounded))
        ],
        backgroundColor: ColorsManager.darkCharcoal,
        centerTitle: true,
        title: CustomText(
          text:  widget.examFormModel.docId,
          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                color: ColorsManager.white,
              ),
        ),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot>>(
          stream: viewModel.examDetailsStream,
          builder: (context, examSnapshot) {
            if (examSnapshot.hasData && examSnapshot.data != null) {
              if (examUiModels.isEmpty) {
                for (var element in examSnapshot.data!) {
                  examUiModels.add(ExamUiModel(
                    TextEditingController(),
                    element.id,
                    "0",
                    (element.data() as Map<String, dynamic>)["totalScore"] ?? 0,
                  ));
                }
              }

              return Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ExamWidget(
                        examUiModel: examUiModels[index],
                        onChangeCompleted: (val) {
                          setState(() {
                            examUiModels[index].score = val;
                          });
                        },
                      );
                    },
                    itemCount: examSnapshot.data?.length,
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: SizeManager.s10,
                    //   crossAxisSpacing: SizeManager.s10,
                    // ),
                  ),
                ),
              );
            }
            return Container();
          }),
    );
  }

  @override
  String getScreenName() {
    return "ExamScreen";
  }

  @override
  initScreen() {
    viewModel.getExamDetails(collectionId: widget.examFormModel.examCollectionId);
    viewModel.findScoreById(collectionId: widget.examFormModel.collectionReferenceId, name: widget.examFormModel.docId);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      viewModel.resultsStream.listen((event) {
        examUiModels.forEach((element) {
          if (event.containsKey(element.title)) {
            element.controller.text = event[element.title].toString();
            element.score = event[element.title].toString();
          } else {
            element.controller.text = 0.toString();
            element.score = 0.toString();
          }
        });
        setState(() {});
      });
    });
  }

  @override
  void onDispose() {}
}
