import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mary/features/home/data/data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : homeRepository = HomeRepositoryImpl(),
        super(const HomeState());

  final HomeRepositoryImpl homeRepository;

  void setPatientsPage() {
    emit(state.copyWith(homeOption: HomeOption.patients));
  }

  void setPatientPage(Patient patient) {
    emit(state.copyWith(
      homeOption: HomeOption.patient,
      patient: patient,
    ));
  }

  void setPatient(Patient patient) {
    emit(state.copyWith(patient: patient, errorMessage: patient.patientDTO.id));
  }

  void setHomePage() {
    emit(state.copyWith(homeOption: HomeOption.home));
  }

  void addPage() {
    emit(state.copyWith(homeOption: HomeOption.add));
  }

  void setEmail(String email) {
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    );

    final passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

    if (!emailRegExp.hasMatch(email) && email.isNotEmpty) {
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

    if (!passwordRegExp.hasMatch(password) && password.isNotEmpty) {
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

  void setRol(int rol) {
    emit(state.copyWith(rol: rol));
  }

  void addloginWithEmailAndPassword() async {
    try {
      emit(state.copyWith(status: Status.loading));
      await homeRepository
          .setPatientLogin(
            email: state.email,
            password: state.password,
            rol: state.rol,
            patient: state.patient!,
          )
          .then((value) => emit(state.copyWith(status: Status.succes)));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: e.toString(),
        ),
      );
    } finally {
      emit(state.copyWith(status: Status.initial, errorMessage: ""));
    }
  }
}
