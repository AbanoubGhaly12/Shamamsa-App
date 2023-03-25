import 'package:core/base/base_use_case.dart';
import '../entity/login_entity.dart';
import '../repository/i_auth_repo.dart';

class LoginUseCase extends BaseUseCase<LoginEntity, void> {
  final IAuthRepo _authRepo;

  LoginUseCase(this._authRepo);

  @override
  Future execute(input) async {
    await _authRepo.login(input);
  }

  Future signOut() async {
    await _authRepo.signOut();
  }
}
