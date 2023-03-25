
import 'package:bot_toast/bot_toast.dart';
import 'package:core/managers/analytics/analytics.dart';
import 'package:core/service_locator/service_locator.dart';
import 'package:core/utils/view/base_view.dart';
import 'package:core/utils/view/navigation/navigation_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../common/resources/color_manager.dart';
import 'base_viewmodel.dart';

/// [BaseState] Replaces [State] in {StateFul Widgets}
/// Example:
/// {class _ScreenState extends BaseState<Screen,ScreenViewModel>{}}
abstract class BaseState<T extends StatefulWidget, V extends BaseViewModel>
    extends State<T> implements BaseView {
  /// Instance of Screen ViewModel
  /// Initialized on Creating View
  late V viewModel;
  CancelFunc? cancelFunc;

  //late IAnalytics analytics;

  /// {dispose()} in [BaseState]
  void onDispose();

  /// {initState()} in [BaseState]
  initScreen();

  /// Setting Screen name for [Analytics]
  String getScreenName();

  Widget buildWidget(BuildContext context);

  @override
  void initState() {
    super.initState();
    //analytics = getInstance<IAnalytics>();
    _initViewModel();
    viewModel.view = this;
    initScreen();
  }

  /// Initialize viewModel Instance from @service_locator
  _initViewModel() {
    viewModel = getInstance<V>();
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel.navigation = NavigationHandler(context: context);
    return buildWidget(context);
  }

  @override
  String localize(String key) {
    return 'r'; //tr(key);
  }

  @override
  void closeKeyboard() {
    FocusScope.of(context).focusedChild?.unfocus();
  }

  @override
  void showProgress() {
    closeKeyboard();
    cancelFunc?.call();

    cancelFunc = BotToast.showCustomLoading(
        toastBuilder: (_) => CircularProgressIndicator(
              color: ColorsManager.white,
            ));
  }

  @override
  void hideProgress() {
    cancelFunc?.call();
  }

  @override
  void showSuccessMsg(String? msg) {
    if (msg == null || msg.isEmpty) return;

    showToast(msg, FontAwesomeIcons.solidCheckCircle, Colors.green);
  }

  @override
  void showErrorMsg(String? msg) {
    if (msg == null || msg.isEmpty) return;

    showToast(
        msg, FontAwesomeIcons.exclamationTriangle, const Color(0xFFF53A56));
  }

  void showAlertDialog(BuildContext context) {}

  void showToast(String msg, IconData icon, Color color) {
    BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      onlyOne: true,
      align: const Alignment(0, 0.8),
      toastBuilder: (_) => Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FaIcon(icon, color: color),
              const SizedBox(width: 16),
              Flexible(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 15, color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<returnType?> showMaterialDialog<returnType>({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    Color? barrierColor = Colors.black54,
    String? barrierLabel,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    return showDialog(context: context, builder: builder);
  }

  @override
  changeSystemColor({required Color color, Brightness? brightness}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: color,
      systemNavigationBarIconBrightness: brightness ?? Brightness.dark,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }
}
