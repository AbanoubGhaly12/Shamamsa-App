import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  String? email;
  String? password;

  LoginEntity({
    this.email,
    this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
