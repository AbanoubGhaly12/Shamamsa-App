import 'package:bot_toast/bot_toast.dart';
import 'package:core/managers/language/i_language_manager.dart';
import 'package:core/managers/notification/i_notification_manager.dart';
import 'package:core/service_locator/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/resources/routes_manager.dart';
import '../../common/resources/theme_manager.dart';


GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp instance = MyApp._internal();

  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ILanguageManager _languageManager = getInstance<ILanguageManager>();
  // final INotificationManager _notificationManager = getInstance<INotificationManager>();

  late String startScreen;

  @override
  void didChangeDependencies() {
    // _notificationManager.init(
    //   onNotificationReceivedInBackground: NotificationHandler.onNotificationReceivedInBackground,
    //   onNotificationClicked: NotificationHandler.onNotificationClicked,
    // );
    _languageManager.languageChanged.stream.listen((language) => _updateContext(language));

    super.didChangeDependencies();
  }

  _updateLocale() {
    _languageManager.getLocal().then((value) => _updateContext(value));
  }

  _updateContext(Locale language) {
    context.setLocale(language);
    Intl.defaultLocale = language.languageCode;
  }

  @override
  void initState() {
    _updateLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: ScreenUtilInit(
          designSize: const Size(428, 926),
          //designSize: const Size(428, 926),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              builder: BotToastInit(),
              navigatorObservers: [BotToastNavigatorObserver()],
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme(),
              onGenerateRoute: RouteGenerator.getRoute,
              initialRoute: FirebaseAuth.instance.currentUser != null ?Routes.departmentRoute:Routes.loginRoute,
            );
          }),
    );
  }
}
