import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/common/widget/custom_text.dart';
import 'package:shamamsa_app/presentation/screen/section/section_viewmodel.dart';
import 'dart:ui' as ui;
import '../../../common/resources/routes_manager.dart';
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
  bool odasCheckBox = false;
  bool tasbehaCheckBox = false;
  bool egtmaaCheckBox = false;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              viewModel.navigation.pushReplacementNamed(
                  route: Routes.scanRoute,
                  arguments: widget.collectionReferenceId);
            },
            icon: Icon(
              Icons.arrow_back,
              color: ColorsManager.background,
            )),
        backgroundColor: ColorsManager.darkCharcoal,
        centerTitle: true,
        title: CustomText(
          text: TextManager.title.tr(),
          style:
              StyleManager.cairoMediumBold.getStyle(context: context).copyWith(
                    color: ColorsManager.white,
                  ),
        ),
      ),
      body: Directionality(
        textDirection: ui.TextDirection.rtl,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: SizeManager.s8,
                  color: ColorsManager.darkCharcoal,
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
              CustomCheckBox(
                value: odasCheckBox,
                onChanged: (value) {
                  setState(() {
                    odasCheckBox = value!;
                  });
                },
                title: TextManager.odas.tr(),
              ),
              CustomCheckBox(
                value: tasbehaCheckBox,
                onChanged: (value) {
                  setState(() {
                    tasbehaCheckBox = value!;
                  });
                },
                title: TextManager.tasbeha.tr(),
              ),
              CustomCheckBox(
                value: egtmaaCheckBox,
                onChanged: (value) {
                  setState(() {
                    egtmaaCheckBox = value!;
                  });
                },
                title: TextManager.egtmaa.tr(),
              ),
              Padding(
                padding: const EdgeInsets.all(SizeManager.s20),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    onPressed: () async {
                      viewModel
                          .setCollection(
                              odasCheckBox: odasCheckBox,
                              tasbehaCheckBox: tasbehaCheckBox,
                              egtmaaCheckBox: egtmaaCheckBox,
                              collectionId: widget.collectionReferenceId,
                              documentId: widget.username)
                          .then((value) => viewModel.navigation
                              .pushReplacementNamed(
                                  route: Routes.scanRoute,
                                  arguments: widget.collectionReferenceId));
                    },
                    text: "تسجيل الحضور",
                    buttonColor: ColorsManager.metallicOrange,
                    width: SizeManager.s150,
                    textStyle:
                        StyleManager.cairoMediumBold.getStyle(context: context),
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
  initScreen() {}

  @override
  void onDispose() {}
}
