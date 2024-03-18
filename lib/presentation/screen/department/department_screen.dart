import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';

import '../../../common/resources/routes_manager.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/resources/text_manager.dart';
import '../../../common/widget/custom_text.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../base/base_state.dart';
import 'department_viewmodel.dart';

class DepartmentScreen extends StatefulWidget {
  const DepartmentScreen({Key? key}) : super(key: key);

  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends BaseState<DepartmentScreen, DepartmentViewModel> {
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: SizeManager.s20, crossAxisSpacing: SizeManager.s20, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: SizeManager.s200,
                            height: SizeManager.s200,
                            child: LayoutBuilder(builder: (context, constraints) {
                              return Card(
                                color: Colors.transparent,
                                elevation: SizeManager.s6,
                                child: GestureDetector(
                                  onTap: () {
                                    viewModel.navigation.pushNamed(route: Routes.homeSettingRoute, arguments: viewModel.items[index]);
                                  },
                                  child: FancyStage1Widget(
                                    Center(
                                      child: CustomText(
                                        text: viewModel.items[index],
                                        align: TextAlign.center,
                                        style: StyleManager.cairoSmallRegular.getStyle(context: context).copyWith(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: viewModel.items.length,
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

class FancyStage1Widget extends StatelessWidget {
  final Widget child;

  FancyStage1Widget(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.darkCharcoal,
            ColorsManager.darkCharcoal.withOpacity(0.5),
            ColorsManager.background.withOpacity(0.5),
            ColorsManager.background.withOpacity(0.5),
            ColorsManager.background,
          ],
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.0),
      child: child,
    );
  }
}
