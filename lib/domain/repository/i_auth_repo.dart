
import '../entity/login_entity.dart';

abstract class IAuthRepo{
  Future<void> login(LoginEntity loginEntity);
  Future<void> register(LoginEntity loginEntity);
  Future<void> signOut();
}