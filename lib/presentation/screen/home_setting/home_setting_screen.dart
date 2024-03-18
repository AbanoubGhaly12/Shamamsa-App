import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/common/widget/custom_button.dart';
import 'package:shamamsa_app/presentation/screen/home_setting/home_setting_viewmodel.dart';

import '../../../common/resources/routes_manager.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/resources/text_manager.dart';
import '../../../common/widget/custom_bottomsheet.dart';
import '../../../common/widget/custom_text.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../base/base_state.dart';

class HomeSettingScreen extends StatefulWidget {
  final String collectionReferenceId;

  const HomeSettingScreen({Key? key, required this.collectionReferenceId}) : super(key: key);

  @override
  State<HomeSettingScreen> createState() => _HomeSettingScreenState();
}

class _HomeSettingScreenState extends BaseState<HomeSettingScreen, HomeSettingViewModel> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.darkCharcoal,
        centerTitle: true,
        title: CustomText(
          text: TextManager.title.tr(),
          style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                color: ColorsManager.white,
              ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: SizeManager.s6,
              borderOnForeground: true,
              color: ColorsManager.darkCharcoal,
              child: ListTile(
                onTap: () {
                  viewModel.navigation.pushNamed(route: Routes.scanRoute, arguments: widget.collectionReferenceId);
                },
                leading: Icon(
                  Icons.qr_code_scanner_sharp,
                  color: ColorsManager.white,
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: 'مسح رمز الاستجابة السريعة (QR Code)',
                    style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                  ),
                ),
              ),
            ),
            Card(
              elevation: SizeManager.s6,
              borderOnForeground: true,
              color: ColorsManager.darkCharcoal,
              child: ListTile(
                onTap: () {
                  viewModel.navigation.pushNamed(route: Routes.detailsRoute, arguments: widget.collectionReferenceId);
                },
                leading: Icon(
                  Icons.add_chart,
                  color: ColorsManager.white,
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: 'كشف حضور ${widget.collectionReferenceId}',
                    style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                  ),
                ),
              ),
            ),
            Card(
              elevation: SizeManager.s6,
              borderOnForeground: true,
              color: ColorsManager.darkCharcoal,
              child: ListTile(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => ClipRRect(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(SizeManager.s20), topRight: Radius.circular(SizeManager.s20)),
                      child: Container(
                        height: SizeManager.s300,
                        color: ColorsManager.darkCharcoal,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomTextField(
                              controller: _nameController,
                              hintText: "الاسم",
                            ),
                            CustomButton(
                              onPressed: () async {
                                if (_nameController.text.isNotEmpty) {
                                  await viewModel.setDocuments(collectionId: widget.collectionReferenceId, documentId: _nameController.text);
                                } else {
                                  viewModel.view?.showErrorMsg("برجاء ادخال الاسم");
                                }
                                _nameController.clear();
                                viewModel.navigation.pop();
                              },
                              text: "اضافة",
                            )
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                  );
                },
                leading: Icon(
                  Icons.create,
                  color: ColorsManager.white,
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: 'اضافة بيانات جديدة',
                    style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                  ),
                ),
              ),
            ),

            // Card(
            //   elevation: SizeManager.s6,
            //   borderOnForeground: true,
            //   color: ColorsManager.darkCharcoal,
            //   child: ListTile(
            //     onTap: () {
            //       viewModel.navigation.pushNamed(route: Routes.examRoute, arguments: widget.collectionReferenceId);
            //     },
            //     leading: Icon(
            //       Icons.add_chart,
            //       color: ColorsManager.white,
            //     ),
            //     title: FittedBox(
            //       fit: BoxFit.scaleDown,
            //       child: CustomText(
            //         text: ' امتحان  ${widget.collectionReferenceId}',
            //         style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
            //       ),
            //     ),
            //   ),
            // ),
            // Card(
            //   elevation: SizeManager.s6,
            //   borderOnForeground: true,
            //   color: ColorsManager.darkCharcoal,
            //   child: ListTile(
            //     onTap: () async {
            //       final result = await FilePicker.platform.pickFiles(allowMultiple: false);
            //       if (result == null) return;
            //       log(result.files.first.path.toString());
            //       final file = File(result.files.first.path.toString());
            //       final fileContent = file.readAsBytesSync();
            //       var excel = Excel.decodeBytes(fileContent);
            //       print(excel.sheets);
            //       Sheet sheet = excel["Sheet1"];
            //       String sheetName = sheet.sheetName;
            //       for (var row in sheet.rows) {
            //         print(row[0]?.value);
            //         if (row[0]?.value != null) {
            //           await viewModel.setDocuments(collectionId: widget.collectionReferenceId, documentId: row[0]!.value.toString());
            //         }
            //       }
            //     },
            //     leading: Icon(
            //       Icons.upload_file,
            //       color: ColorsManager.white,
            //     ),
            //     title: FittedBox(
            //       fit: BoxFit.scaleDown,
            //       child: CustomText(
            //         text: 'تسجيل بيانات  ${widget.collectionReferenceId} من الملفات ',
            //         style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  String getScreenName() {
    return "Demo Screen";
  }

  @override
  initScreen() {}

  @override
  void onDispose() {}
}
