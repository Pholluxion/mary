import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mary/features/login/data/exeptions/login_exceptions.dart';
import 'package:mary/features/login/domain/entity/login_dto.dart';
import 'package:mary/features/login/domain/repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepository) : super(const LoginState());

  final LoginRepository loginRepository;

  void setEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (!emailRegExp.hasMatch(email)) {
      emit(state.copyWith(emailErrorMessage: "Correo no valido"));
    } else {
      emit(
        state.copyWith(
          email: email,
          emailErrorMessage: "",
          validForm: emailRegExp.hasMatch(email) &&
              passwordRegExp.hasMatch(state.password),
        ),
      );
    }
  }

  void setPassword(String password) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (!passwordRegExp.hasMatch(password)) {
      emit(
        state.copyWith(passwordErrorMessage: "Formato de contraseña no valido"),
      );
    } else {
      emit(
        state.copyWith(
          password: password,
          passwordErrorMessage: "",
          validForm: passwordRegExp.hasMatch(password) &&
              emailRegExp.hasMatch(state.email),
        ),
      );
    }
  }

  void loginWithEmailAndPassword() async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await loginRepository
          .loginWithEmailAndPassword(
            loginDTO: LoginDTO(email: state.email, password: state.password),
          )
          .then(
            (value) => value
                ? emit(state.copyWith(status: LoginStatus.succes))
                : emit(
                    state.copyWith(
                      status: LoginStatus.error,
                      errorMessage: "Ups, algo no está bien",
                    ),
                  ),
          );
    } on LogInWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LoginStatus.error,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      emit(state.copyWith(status: LoginStatus.initial, errorMessage: ""));
    }
  }
}
