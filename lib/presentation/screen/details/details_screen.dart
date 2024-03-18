import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/enums/document_type.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/routes_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/common/widget/custom_bottomsheet.dart';
import 'package:shamamsa_app/presentation/model/ExamFormModel.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/resources/text_manager.dart';
import '../../../common/widget/custom_text.dart';
import '../../base/base_state.dart';
import 'details_viewmodel.dart';

class DetailsScreen extends StatefulWidget {
  final String collectionReferenceId;
  final bool isAttendanceScreen;

  const DetailsScreen({Key? key, required this.collectionReferenceId, required this.isAttendanceScreen}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends BaseState<DetailsScreen, DetailsViewModel> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.darkCharcoal,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
             widget.isAttendanceScreen? await viewModel.getAttendanceForAllStudents(collectionId: widget.collectionReferenceId):await viewModel.getExamScoreCsv(collectionId: "نتيجة اسرة البابا كيرلس");
            },
            icon: const Icon(Icons.table_view_sharp,color: Colors.white,),
          ),
        ],
        title: CustomText(
          text: TextManager.title.tr(),
          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                color: ColorsManager.white,
              ),
        ),
      ),
      body: StreamBuilder<List<QueryDocumentSnapshot>>(
          stream: viewModel.dataStream,
          builder: (context, namesSnapshot) {
            if (namesSnapshot.hasData && namesSnapshot.data != null) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: SizeManager.s6,
                    borderOnForeground: true,
                    color: ColorsManager.darkCharcoal,
                    child: ListTile(
                      onTap: () async {
                        viewModel.navigation.pushNamed(route: Routes.sectionRoute, arguments: [widget.collectionReferenceId, namesSnapshot.data![index].id]);

                        // if (widget.isAttendanceScreen) {
                        //   viewModel.getAttendance(collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id).then((value) => showModalBottomSheet(
                        //         context: context,
                        //         builder: (context) => ClipRRect(
                        //           borderRadius: const BorderRadius.only(topLeft: Radius.circular(SizeManager.s20), topRight: Radius.circular(SizeManager.s20)),
                        //           child: Container(
                        //             height: SizeManager.s200,
                        //             color: ColorsManager.metallicOrange,
                        //             child: CustomBottomSheet(
                        //               egtmaaStream: viewModel.egtmaaStream,
                        //               tasbehaStream: viewModel.tasbehaStream,
                        //               odasStream: viewModel.odasStream,
                        //               onPressed1: (bool flag) async {
                        //                 // if (flag) {
                        //                 //   viewModel
                        //                 //       .setCollection(documentType: DocumentType.EGTMAA, collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id)
                        //                 //       .then((value) => viewModel.getAttendance(collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id));
                        //                 // }
                        //               },
                        //               onPressed2: (bool flag) {
                        //                 // if (flag) {
                        //                 //   viewModel
                        //                 //       .setCollection(documentType: DocumentType.TASBEHA, collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id)
                        //                 //       .then((value) => viewModel.getAttendance(collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id));
                        //                 // }
                        //               },
                        //               onPressed3: (bool flag) {
                        //                 // if (flag) {
                        //                 //   viewModel
                        //                 //       .setCollection(documentType: DocumentType.ODAS, collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id)
                        //                 //       .then((value) => viewModel.getAttendance(collectionId: widget.collectionReferenceId, documentId: namesSnapshot.data![index].id));
                        //                 // }
                        //               },
                        //             ),
                        //           ),
                        //         ),
                        //         backgroundColor: Colors.transparent,
                        //       ));
                        // } else {
                        //   viewModel.navigation.pushNamed(
                        //       route: Routes.examFormRoute,
                        //       arguments: ExamFormModel(collectionReferenceId: "نتيجة اسرة البابا كيرلس", examCollectionId: "امتحان الحان اسرة البابا كيرلس", docId: namesSnapshot.data![index].id));
                        // }

                      },
                      leading: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: (index + 1).toString(),
                          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                        ),
                      ),
                      title: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: CustomText(
                          text: namesSnapshot.data![index].id,
                          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: namesSnapshot.data?.length,
              );
            }
            return Container();
          }),
    );
  }

  @override
  String getScreenName() {
    return "Demo Screen";
  }

  @override
  initScreen() {
    viewModel.getAllDocuments(collectionId: widget.collectionReferenceId);
  }

  @override
  void onDispose() {}
}
