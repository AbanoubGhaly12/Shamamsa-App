import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shamamsa_app/common/resources/color_manager.dart';
import 'package:shamamsa_app/common/resources/style_manager.dart';
import 'package:shamamsa_app/common/resources/text_manager.dart';
import 'package:shamamsa_app/common/widget/custom_button.dart';
import 'package:shamamsa_app/common/widget/custom_text.dart';
import 'dart:ui' as ui;
import '../../../common/resources/routes_manager.dart';
import '../../../common/resources/size_manager.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../base/base_state.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  Widget buildWidget(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorsManager.darkCharcoal,
        body: SafeArea(

          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(SizeManager.s20),
                      child: CustomText(
                        align: TextAlign.center,
                        text: "نظام حضور \n اسرة الشمامسة",
                        style: StyleManager.cairoMediumBold
                            .getStyle(context: context)
                            .copyWith(color: ColorsManager.metallicOrange,
                            fontSize: SizeManager.s30),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(SizeManager.s20),
                    child: StreamBuilder<bool>(
                        stream: viewModel.isValidNameStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            controller: emailController,
                            hintText: TextManager.email.tr(),
                            validationText: TextManager.emailError.tr(),
                            errorText: (snapshot.data ?? true)
                                ? null
                                : TextManager.emailError.tr(),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SizeManager.s20),
                    child: StreamBuilder<bool>(
                        stream: viewModel.isValidPasswordStream,
                        builder: (context, snapshot) {
                          return CustomTextField(
                            controller: passwordController,
                            hintText: TextManager.password.tr(),
                            obscure: true,
                            errorText: (snapshot.data ?? true)
                                ? null
                                : TextManager.passwordError.tr(),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: SizeManager.s30,
                  ),
                  StreamBuilder<bool>(
                      stream: viewModel.isAllInputValidStream,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.all(SizeManager.s20),
                          child: CustomButton(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            onPressed:
                            // (snapshot.data ?? false)
                            //     ?
                                () async {
                              viewModel.login().then((value) =>
                                  viewModel.navigation.pushReplacementNamed(
                                      route: Routes.departmentRoute));
                            },
                                // : () =>
                                // viewModel.view?.showErrorMsg(
                                //     TextManager.validation.tr()),
                            buttonColor: ColorsManager.metallicOrange,

                            text: TextManager.login.tr(),
                          ),
                        );
                      }),

                ],
              )),
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
    emailController = TextEditingController()
      ..addListener(() {
        viewModel.inputUser(emailController.text);
      });
    passwordController = TextEditingController()
      ..addListener(() {
        viewModel.inputPassword(passwordController.text);
      });
  }

  @override
  void onDispose() {}
}
