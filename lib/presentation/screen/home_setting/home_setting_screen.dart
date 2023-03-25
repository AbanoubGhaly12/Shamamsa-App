import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/presentation/screen/home_setting/home_setting_viewmodel.dart';

import '../../../common/resources/routes_manager.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/resources/text_manager.dart';
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
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(allowMultiple: false);
                  if (result == null) return;
                  log(result.files.first.path.toString());
                  final file = File(result.files.first.path.toString());
                  final fileContent = await file.readAsString();
                  Map<String, dynamic> json = jsonDecode(fileContent);
                  log(fileContent);
                  if (json["data"] != null && json["data"]?.isNotEmpty == true) {
                    for (int i = 0; i < json["data"]!.length; i++) {
                      if (json["data"]?[i] != null) {
                        print(json["data"]?[i]);
                        print(i);
                        await viewModel.setDocuments(collectionId: widget.collectionReferenceId, documentId: json["data"]![i]["name"].toString());
                      }
                    }
                  }
                },
                leading: Icon(
                  Icons.upload_file,
                  color: ColorsManager.white,
                ),
                title: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CustomText(
                    text: 'تسجيل بيانات  ${widget.collectionReferenceId} من الملفات ',
                    style: StyleManager.cairoMediumBold.getStyle(context: context).copyWith(color: ColorsManager.white),
                  ),
                ),
              ),
            ),
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
