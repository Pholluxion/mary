part of 'home_cubit.dart';

enum HomeOption { home, patients, patient, add }

enum Status { initial, loading, error, succes, select }

class HomeState extends Equatable {
  const HomeState({
    this.homeOption = HomeOption.home,
    this.patient,
    this.validForm = false,
    this.rol = 0,
    this.password = "",
    this.email = "",
    this.emailErrorMessage = "",
    this.passwordErrorMessage = "",
    this.errorMessage = "",
    this.status = Status.initial,
  });

  final HomeOption homeOption;
  final Patient? patient;
  final String email;
  final bool validForm;
  final int rol;
  final String password;
  final String emailErrorMessage;
  final String passwordErrorMessage;
  final String errorMessage;
  final Status status;

  HomeState copyWith({
    HomeOption? homeOption,
    Patient? patient,
    bool? validForm,
    int? rol,
    String? email,
    String? password,
    String? emailErrorMessage,
    String? passwordErrorMessage,
    String? errorMessage,
    Status? status,
  }) =>
      HomeState(
        status: status ?? this.status,
        homeOption: homeOption ?? this.homeOption,
        patient: patient ?? this.patient,
        email: email ?? this.email,
        password: password ?? this.password,
        validForm: validForm ?? this.validForm,
        emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
        passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
        errorMessage: errorMessage ?? this.errorMessage,
        rol: rol ?? this.rol,
      );

  @override
  List<Object> get props => [
        homeOption,
        email,
        password,
        emailErrorMessage,
        passwordErrorMessage,
        validForm,
        errorMessage,
        rol,
        status,
      ];
}
