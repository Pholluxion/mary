part of 'home_cubit.dart';

enum HomeOption { home, patients, patient }

class HomeState extends Equatable {
  const HomeState({
    this.homeOption = HomeOption.home,
    this.patient,
  });

  final HomeOption homeOption;
  final Patient? patient;

  HomeState copyWith({
    HomeOption? homeOption,
    Patient? patient,
  }) =>
      HomeState(
        homeOption: homeOption ?? this.homeOption,
        patient: patient ?? this.patient,
      );

  @override
  List<Object> get props => [homeOption];
}
