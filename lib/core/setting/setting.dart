import 'dart:io';

import 'package:core/models/app_settings.dart';
import 'package:core/models/notification_settings.dart';
import 'package:core/utils/enums/env.dart';
import 'package:core/utils/enums/language.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../firebase_options.dart';

class Setting extends AppSettings {
  final Env _env = Env.DEV;

  Setting() {
    super.environment = _env.name;
    super.defaultLanguage = LanguageType.ARABIC.getValue();
    super.currentLanguage = defaultLanguage;
    super.buildVersion = "1.0.0";
    super.platform = Platform.isAndroid ? "android" : "iOS";
    super.appUnifiedName = "Clync";
    switch (_env) {
      case Env.DEV:
        super.authUrl = "authUrlStaging";
        super.baseUrl = "baseUrlStaging";
        super.clientId = "clientIDStaging";
        break;
      case Env.PROD:
        super.authUrl = "authUrlProd";
        super.baseUrl = "baseUrlProd";
        super.clientId = "clientIDProd";
        break;
    }
    super.notificationSettings = NotificationSettings(
        controllerName: "notification-service/",
        firebaseOptions: DefaultFirebaseOptions.currentPlatform,
        androidInitializationSettings:
        const AndroidInitializationSettings('clync_logo'),
        androidNotificationChannel: const AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          'This channel is used for important notifications.',
          showBadge: true,
          enableLights: true,
          importance: Importance.high,
        ),
        iosInitializationSettings: const IOSInitializationSettings(
          defaultPresentAlert: true,
          defaultPresentBadge: true,
          defaultPresentSound: true,
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ));
  }
}
