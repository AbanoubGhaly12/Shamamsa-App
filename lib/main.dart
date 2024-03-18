import 'package:core/utils/enums/language.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'core/app/app.dart';
import 'core/service_locator/service_locator.dart';

Future<void> main() async {
  // SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
  //   statusBarBrightness: Brightness.light,
  //   statusBarIconBrightness: Brightness.light,
  //   statusBarColor: ColorManager.background
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  await initRepos();


  runApp(EasyLocalization(
    supportedLocales: const [ENGLISH_LOCAL, ARABIC_LOCAL],
    path: ASSETS_PATH_LOCALISATIONS,
    child: Phoenix(child: MyApp()),
  ));
}
