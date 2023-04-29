import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entity/login_dto.dart';
import '../exeptions/login_exceptions.dart';
import '../../domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      throw LogOutFailure();
    }
  }

  @override
  Future<bool> loginWithEmailAndPassword({required LoginDTO loginDTO}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: loginDTO.email,
        password: loginDTO.password,
      );
      return _firebaseAuth.currentUser?.uid.isNotEmpty ?? false;
    } on FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      log(e.toString());
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  @override
  Future<void> sendRecoveryPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw SendPasswordResetEmailFailure.fromCode(e.code);
    } catch (e) {
      log(e.toString());
      throw const SendPasswordResetEmailFailure();
    }
  }
}
