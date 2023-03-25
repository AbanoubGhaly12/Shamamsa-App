import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/entity/login_entity.dart';
import '../../domain/repository/i_auth_repo.dart';

class AuthRepo extends IAuthRepo {
  @override
  Future<void> login(LoginEntity loginEntity) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: loginEntity.email!, password: loginEntity.password!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await register(loginEntity);
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> register(LoginEntity loginEntity) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: loginEntity.email!,
        password: loginEntity.password!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
