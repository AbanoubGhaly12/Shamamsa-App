import 'dart:async';

import 'package:core/base/base_use_case.dart';
import 'package:core/managers/network_info/i_network_info.dart';
import 'package:core/managers/session/i_session_manager.dart';
import 'package:core/models/exceptions/authorization_exception.dart';
import 'package:core/models/exceptions/base_exception.dart';
import 'package:core/models/exceptions/business_exception.dart';
import 'package:core/models/exceptions/errorResponses/error_response.dart';
import 'package:core/models/exceptions/internal_server_error_exception.dart';
import 'package:core/models/exceptions/network_exception.dart';
import 'package:core/service_locator/service_locator.dart';
import 'package:core/utils/view/base_view.dart';
import 'package:core/utils/view/navigation/base_navigation.dart';
import 'package:dio/dio.dart';

import '../../common/resources/routes_manager.dart';


/// [BaseViewModel]
/// Handle [Business Logic] of the View
/// Connects [View] with [BaseUseCase]
/// Initialized in [BaseState]
/// Type of [BaseViewModel] is Assigned When [BaseState] Starts
/// Example:
/// {class _ScreenState extends BaseState<Screen,ScreenViewModel>{}}
abstract class BaseViewModel {
  /// Instance of [BaseView] Must be Initialized
  /// in {initScreen()} in [BaseState]
  BaseView? view;

  /// Loading Indicator
  bool isLoading = false;

  /// Instance of [BaseNavigation] Must be Initialized
  /// in {build()} in [BaseState]
  late BaseNavigation navigation;

  /// Getting [INetworkInfo] Singleton
  /// To Check Connectivity
  final INetworkInfo networkInfo = getInstance.get<INetworkInfo>();

  /// Error Handler
  /// Get the Exception
  /// and [Throw] it inside the [View]
  Future handleError(dynamic e) async {
    var exception = e.runtimeType == DioError ? e.error : e;
    switch (exception.runtimeType) {
      case AuthorizationException:
        {
          final ErrorResponse errorResponse = exception.errorResponse;
          view?.showErrorMsg("${errorResponse.errorMessage}");

          final ISessionManager sessionManager =
              getInstance.get<ISessionManager>();

          if (!await sessionManager.isAnonymousSession()) {
            sessionManager.endSession();
            navigation.pushReplacementNamedWithRootNavigator(
                route: Routes.loginRoute);
          }
        }
        break;
      case InternalServerErrorException:
        {
          final ErrorResponse errorResponse = exception.errorResponse;
          var messageBuffer = StringBuffer();
          if (errorResponse.errorMessage != null) {
            messageBuffer.write(errorResponse.errorMessage);
            errorResponse.errors?.forEach((key, value) {
              messageBuffer.write('\n');
              messageBuffer.write(value.join('\n'));
            });
          } else {
            messageBuffer.write(
                "Service is currently unavailable or internal service error, please try again later - ${errorResponse.errorCode}");
          }

          view?.showErrorMsg(messageBuffer.toString());
        }

        break;
      case NetworkException:
        {
          final ErrorResponse errorResponse = exception.errorResponse;
          var message = errorResponse.errorMessage ??
              "Service is currently unavailable - ${errorResponse.errorCode}";
          view?.showErrorMsg(message);
        }

        break;
      case BaseException:
        {
          final ErrorResponse errorResponse = exception.errorResponse;
          view?.showErrorMsg(
              "${errorResponse.errorMessage} - ${errorResponse.errorCode}");
        }
        break;
      case BusinessException:
        {
          final ErrorResponse errorResponse = exception.errorResponse;
          view?.showErrorMsg(errorResponse.errorMessage);
        }
        break;
      default:
        {
          view?.showErrorMsg("Something went wrong, please try again later!");
        }
        break;
    }
  }

  /// Run Safe Method
  /// Here we inject the [execute] function from the [UseCase]
  /// To be Handled with {try{}catch(e){}} Statement
  Future<T?> runSafe<T>(Future<T?>? Function() future,
      [bool showLoading = true]) async {
    try {
      if (!await networkInfo.isConnected) {
        throw NetworkException(
            errorResponse: ErrorResponse(
                errorMessage:
                    "No Internet Connection, Check your network please!"),
            requestOptions: RequestOptions(path: ''));
      }

      if (showLoading) view?.showProgress();
      isLoading = true;
      return await future();
    } catch (ex) {
      await handleError(ex);
    } finally {
      if (showLoading) view?.hideProgress();
      isLoading = false;
    }

    return null;
  }

  /// Run Safe Method
  /// Here we inject the [execute] function from the [UseCase]
  /// To be Handled with {try{}catch(e){}} Statement
  Future<T?> runSafeWithNavigation<T>(
      {required Future<T?>? Function() future,
      required Function navigateSuccess,
      required Function navigateError,
      bool showLoading = true}) async {
    try {
      if (!await networkInfo.isConnected) {
        throw NetworkException(
            errorResponse: ErrorResponse(
                errorMessage:
                    "No Internet Connection, Check your network please!"),
            requestOptions: RequestOptions(path: ''));
      }

      if (showLoading) view?.showProgress();
      await future();
      navigateSuccess();
    } catch (ex) {
      await handleError(ex);
      navigateError();
    } finally {
      if (showLoading) view?.hideProgress();
    }

    return null;
  }

  void onDispose();

  showErrorMessage({required String message}) {
    view?.showErrorMsg(message);
  }
}
