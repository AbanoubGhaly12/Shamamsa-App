import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/common/widget/custom_text.dart';
import 'package:shamamsa_app/presentation/screen/section/section_viewmodel.dart';
import 'dart:ui' as ui;
import '../../../common/resources/size_manager.dart';
import '../../../common/widget/custom_button.dart';
import '../../../common/widget/custom_checkbox.dart';
import '../../base/base_state.dart';

class SectionsScreen extends StatefulWidget {
  final String collectionReferenceId;
  final String username;

  const SectionsScreen({
    Key? key,
    required this.collectionReferenceId,
    required this.username,
  }) : super(key: key);

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends BaseState<SectionsScreen, SectionViewModel> {
  bool fridayLitrugyCheckBox = false;
  bool sundayLitrugyCheckBox = false;
  bool eveCheckBox = false;
  bool classCheckbox = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              viewModel.navigation.pop();
              // viewModel.navigation.pushReplacementNamed(
              //     route: Routes.scanRoute,
              //     arguments: widget.collectionReferenceId);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorsManager.background,
            )),
        backgroundColor: ColorsManager.darkCharcoal,
        centerTitle: true,
        title: CustomText(
          text: TextManager.title.tr(),
          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                color: ColorsManager.white,
              ),
        ),
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    StreamBuilder<List<QueryDocumentSnapshot>?>(
                        stream: viewModel.sundayLitrugyStream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: SizeManager.s8,
                              color: ColorsManager.metallicOrange,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "قداس الاحد : ${snapshot.data?.isEmpty == true || snapshot.data == null ? 0 : snapshot.data?.length.toString()}",
                                        style: TextStyle(
                                          fontSize: SizeManager.s20,
                                          color: ColorsManager.darkCharcoal,
                                        ),
                                      ),
                                      StreamBuilder<DateTime?>(
                                        stream: viewModel.lastSundayLitrugyStream,
                                        builder: (context, lastSundayLitrugySnapshot) {
                                          return Expanded(
                                            child: CustomText(
                                              text: "اخر حضور : ${lastSundayLitrugySnapshot.data != null?DateFormat.yMMMd().format(lastSundayLitrugySnapshot.data!) : "لا يوجد حضور"}",
                                              style: TextStyle(
                                                fontSize: SizeManager.s20,
                                                color: ColorsManager.darkCharcoal,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          await snapshot.data?.last.reference.delete();
                                          await viewModel.getAttendance(
                                            collectionId: widget.collectionReferenceId,
                                            documentId: widget.username,
                                          );
                                        },
                                        text: "حذف اخر حضور",
                                        buttonColor: ColorsManager.darkCharcoal,
                                        width: SizeManager.s150,
                                        textStyle: StyleManager.cairoMediumBold.getStyle(context: context),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    StreamBuilder<List<QueryDocumentSnapshot>?>(
                        stream: viewModel.fridayLitrugyStream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: SizeManager.s8,
                              color: ColorsManager.metallicOrange,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "قداسات  : ${snapshot.data?.isEmpty == true || snapshot.data == null ? 0 : snapshot.data?.length.toString()}",
                                        style: TextStyle(
                                          fontSize: SizeManager.s20,
                                          color: ColorsManager.darkCharcoal,
                                        ),
                                      ),
                                      StreamBuilder<DateTime?>(
                                        stream: viewModel.lastFridayLitrugyStream,
                                        builder: (context, lastFridayLitrugySnapshot) {
                                          return Expanded(
                                            child: CustomText(
                                              text: "اخر حضور : ${lastFridayLitrugySnapshot.data != null?DateFormat.yMMMd().format(lastFridayLitrugySnapshot.data!) : "لا يوجد حضور"}",
                                              style: TextStyle(
                                                fontSize: SizeManager.s20,
                                                color: ColorsManager.darkCharcoal,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          await snapshot.data?.last.reference.delete();
                                          await viewModel.getAttendance(
                                            collectionId: widget.collectionReferenceId,
                                            documentId: widget.username,
                                          );
                                        },
                                        text: "حذف اخر حضور",
                                        buttonColor: ColorsManager.darkCharcoal,
                                        width: SizeManager.s150,
                                        textStyle: StyleManager.cairoMediumBold.getStyle(context: context),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    StreamBuilder<List<QueryDocumentSnapshot>?>(
                        stream: viewModel.classStream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: SizeManager.s8,
                              color: ColorsManager.metallicOrange,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "الحصة : ${snapshot.data?.isEmpty == true || snapshot.data == null ? 0 : snapshot.data?.length.toString()}",
                                        style: TextStyle(
                                          fontSize: SizeManager.s20,
                                          color: ColorsManager.darkCharcoal,
                                        ),
                                      ),
                                      StreamBuilder<DateTime?>(
                                        stream: viewModel.lastClassStream,
                                        builder: (context, lastClassSnapshot) {
                                          return Expanded(
                                            child: CustomText(
                                              text: "اخر حضور : ${lastClassSnapshot.data != null?DateFormat.yMMMd().format(lastClassSnapshot.data!) : "لا يوجد حضور"}",
                                              style: TextStyle(
                                                fontSize: SizeManager.s20,
                                                color: ColorsManager.darkCharcoal,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          await snapshot.data?.last.reference.delete();
                                          await viewModel.getAttendance(
                                            collectionId: widget.collectionReferenceId,
                                            documentId: widget.username,
                                          );
                                        },
                                        text: "حذف اخر حضور",
                                        buttonColor: ColorsManager.darkCharcoal,
                                        width: SizeManager.s150,
                                        textStyle: StyleManager.cairoMediumBold.getStyle(context: context),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    StreamBuilder<List<QueryDocumentSnapshot>?>(
                        stream: viewModel.eveStream,
                        builder: (context, snapshot) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: SizeManager.s8,
                              color: ColorsManager.metallicOrange,
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: "العشية : ${snapshot.data?.isEmpty == true || snapshot.data == null ? 0 : snapshot.data?.length.toString()}",
                                        style: TextStyle(
                                          fontSize: SizeManager.s20,
                                          color: ColorsManager.darkCharcoal,
                                        ),
                                      ),
                                      StreamBuilder<DateTime?>(
                                        stream: viewModel.lastEveStream,
                                        builder: (context,  lastEveSnapshot) {
                                          return Expanded(
                                            child: CustomText(
                                              text: "اخر حضور : ${lastEveSnapshot.data != null?DateFormat.yMMMd().format(lastEveSnapshot.data!) : "لا يوجد حضور"}",
                                              style: TextStyle(
                                                fontSize: SizeManager.s20,
                                                color: ColorsManager.darkCharcoal,
                                              ),
                                            ),
                                          );
                                        }
                                      ),
                                      CustomButton(
                                        onPressed: () async {
                                          await snapshot.data?.last.reference.delete();
                                          await viewModel.getAttendance(
                                            collectionId: widget.collectionReferenceId,
                                            documentId: widget.username,
                                          );
                                        },
                                        text: "حذف اخر حضور",
                                        buttonColor: ColorsManager.darkCharcoal,
                                        width: SizeManager.s150,
                                        textStyle: StyleManager.cairoMediumBold.getStyle(context: context),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: SizeManager.s8,
                  color: ColorsManager.darkCharcoal,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        widget.username,
                        style: TextStyle(
                          fontSize: SizeManager.s20,
                          color: ColorsManager.background,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              CustomCheckBox(
                value: sundayLitrugyCheckBox,
                onChanged: (value) {
                  setState(() {
                    sundayLitrugyCheckBox = value!;
                  });
                },
                title: "قداس الاحد",
              ),
              CustomCheckBox(
                value: fridayLitrugyCheckBox,
                onChanged: (value) {
                  setState(() {
                    fridayLitrugyCheckBox = value!;
                  });
                },
                title: "قداسات",
              ),

              CustomCheckBox(
                value: eveCheckBox,
                onChanged: (value) {
                  setState(() {
                    eveCheckBox = value!;
                  });
                },
                title: "العشية",
              ),

              CustomCheckBox(
                value: classCheckbox,
                onChanged: (value) {
                  setState(() {
                    classCheckbox = value!;
                  });
                },
                title: "الحصة",
              ),
              // CustomCheckBox(
              //   value: tasbehaCheckBox,
              //   onChanged: (value) {
              //     setState(() {
              //       tasbehaCheckBox = value!;
              //     });
              //   },
              //   title: TextManager.tasbeha.tr(),
              // ),

              Padding(
                padding: const EdgeInsets.all(SizeManager.s20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onPressed: () async {
                      if (sundayLitrugyCheckBox == true) {
                        viewModel.setCollection(odasCheckBox: sundayLitrugyCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "قداس الاحد");
                      }
                      if (fridayLitrugyCheckBox == true) {
                        viewModel.setCollection(odasCheckBox: fridayLitrugyCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "قداس الجمعة");
                      }
                      if (eveCheckBox == true) {
                        viewModel.setCollection(odasCheckBox: eveCheckBox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "العشية");
                      }
                      if (classCheckbox == true) {
                        viewModel.setCollection(odasCheckBox: classCheckbox, collectionId: widget.collectionReferenceId, documentId: widget.username, day: "الحصة");
                      }
                    },
                    text: "تسجيل الحضور",
                    buttonColor: ColorsManager.metallicOrange,
                    width: SizeManager.s150,
                    textStyle: StyleManager.cairoMediumBold.getStyle(context: context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  String getScreenName() {
    return "Demo Screen";
  }

  @override
  initScreen() {
    viewModel.getAttendance(
      collectionId: widget.collectionReferenceId,
      documentId: widget.username,
    );
  }

  @override
  void onDispose() {}
}
