import '../entity/entity.dart';

abstract class LoginRepository {
  Future<bool> loginWithEmailAndPassword({required LoginDTO loginDTO});
  Future<void> sendRecoveryPassword({required String email});
  Future<void> logOut();
}
