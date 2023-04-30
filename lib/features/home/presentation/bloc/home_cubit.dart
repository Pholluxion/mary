import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mary/features/home/data/data.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setPatientsPage() {
    emit(state.copyWith(homeOption: HomeOption.patients));
  }

  void setPatientPage(Patient patient) {
    emit(state.copyWith(
      homeOption: HomeOption.patient,
      patient: patient,
    ));
  }

  void setHomePage() {
    emit(state.copyWith(homeOption: HomeOption.home));
  }
}
