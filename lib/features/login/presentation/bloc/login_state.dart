part of 'login_cubit.dart';

enum LoginStatus { initial, loading, error, succes }

enum LoginForm { login, recovery, help }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.loginForm = LoginForm.login,
    this.validForm = false,
    this.password = "",
    this.email = "",
    this.emailErrorMessage = "",
    this.passwordErrorMessage = "",
    this.errorMessage = "",
  });

  final String email;
  final bool validForm;
  final String password;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String errorMessage;
  final LoginStatus status;
  final LoginForm loginForm;

  LoginState copyWith({
    bool? validForm,
    String? email,
    String? password,
    String? errorMessage,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    LoginStatus? status,
    LoginForm? loginForm,
  }) =>
      LoginState(
        email: email ?? this.email,
        status: status ?? this.status,
        password: password ?? this.password,
        loginForm: loginForm ?? this.loginForm,
        validForm: validForm ?? this.validForm,
        errorMessage: errorMessage ?? this.errorMessage,
        emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      );

  @override
  List<Object?> get props => [
        email,
        password,
        validForm,
        status,
        emailErrorMessage,
        passwordErrorMessage,
        errorMessage,
        loginForm,
      ];
}
