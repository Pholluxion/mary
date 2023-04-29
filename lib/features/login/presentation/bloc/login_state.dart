part of 'login_cubit.dart';

enum LoginStatus { initial, loading, error, succes }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
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
  final LoginStatus status;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String errorMessage;

  LoginState copyWith({
    bool? validForm,
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
    String? emailErrorMessage,
    String? passwordErrorMessage,
  }) =>
      LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
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
      ];
}
