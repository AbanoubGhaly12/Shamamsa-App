import 'dart:async';

import 'package:core/utils/string_validations/string_validations.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entity/login_entity.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../base/base_viewmodel.dart';

class LoginViewModel extends BaseViewModel with LoginViewModelInputs, LoginViewModelOutputs {
  LoginUseCase _loginUsecase;

  LoginViewModel(this._loginUsecase);

  final StreamController<String> _usernameInputStreamController = BehaviorSubject<String>();
  final StreamController<String> _passwordInputStreamController = BehaviorSubject<String>();
  final StreamController<void> _isAllInputValidStreamController = BehaviorSubject<void>();

  LoginEntity loginEntity = LoginEntity();

  @override
  void onDispose() {
    _usernameInputStreamController.close();
    _passwordInputStreamController.close();
  }

  Future _login() async {
    await _loginUsecase.execute(loginEntity);
  }

  @override
  Sink get inputPasswordSink => _passwordInputStreamController.sink;

  @override
  Sink get inputUsernameSink => _usernameInputStreamController.sink;

  @override
  Stream<bool> get isValidNameStream => _usernameInputStreamController.stream.map((event) => _validateEmail(event));

  @override
  Stream<bool> get isValidPasswordStream => _passwordInputStreamController.stream.map((event) => _validatePassword(event));

  bool _validateEmail(String val) {
    return val.isNotEmpty && val.isEmailValid();
  }

  bool _validatePassword(String val) {
    return val.isNotEmpty && val.length >= 8;
  }

  inputUser(String val) {
    loginEntity.email = val;
    inputUsernameSink.add(val);
    isAllInputValidSink.add(null);
  }

  inputPassword(String val) {
    loginEntity.password = val;
    inputPasswordSink.add(val);
    isAllInputValidSink.add(null);
  }

  @override
  Sink get isAllInputValidSink => _isAllInputValidStreamController.sink;

  @override
  Stream<bool> get isAllInputValidStream => _isAllInputValidStreamController.stream.map((event) => _validate());

  bool _validate() {
    return _validateEmail(loginEntity.email ?? "") && _validatePassword(loginEntity.password ?? "");
  }

  @override
  Future login() async {
    await runSafe(() async {
      if (loginEntity.isValid) {
        await _login();
      } else {
        view?.showErrorMsg("Invalid email or password");
      }
    });
  }

  Future signOut() async {
    await runSafe(() async {
      await _loginUsecase.signOut();
    });
  }
}

abstract class LoginViewModelInputs {
  Stream<bool> get isValidNameStream;

  Stream<bool> get isValidPasswordStream;

  Stream<bool> get isAllInputValidStream;
}

abstract class LoginViewModelOutputs {
  Sink get inputUsernameSink;

  Sink get inputPasswordSink;

  Sink get isAllInputValidSink;

  Future login();
}
