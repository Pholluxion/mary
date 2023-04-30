import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/home/data/data.dart';
import 'package:mary/features/home/presentation/widgets/patient_view.dart';

import '../bloc/home_cubit.dart';
import '../widgets/patients_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepositoryImpl(),
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeView(),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: context.inversePrimaryColor,
            title: (state.homeOption == HomeOption.patients)
                ? const Text("Mis pacientes")
                : (state.homeOption == HomeOption.home)
                    ? const Text("Mi Dashboard")
                    : null,
          ),
          body: (state.homeOption == HomeOption.home)
              ? const HomeDashBoard()
              : (state.homeOption == HomeOption.patient)
                  ? PatientView(patient: state.patient!)
                  : const PatientsView(),
        );
      },
    );
  }
}

class HomeDashBoard extends StatelessWidget {
  const HomeDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: const Color(0xFF61DE93),
              label: SizedBox(
                width: double.infinity,
                child: FutureBuilder<List<Patient>>(
                  future: context.read<HomeRepositoryImpl>().getPatients(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          Chip(
                            label: Column(
                              children: [
                                const Text("Pacientes"),
                                Text(
                                  snapshot.data?.length.toString() ?? "",
                                  style: context.getTextTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                          Chip(
                            label: Column(
                              children: [
                                const Text("Visitas"),
                                Text(
                                  snapshot.data
                                          ?.asMap()
                                          .entries
                                          .map((e) =>
                                              e.value.medicalVisits.length)
                                          .toList()
                                          .reduce(
                                            (value, element) => value + element,
                                          )
                                          .toString() ??
                                      "",
                                  style: context.getTextTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                          Chip(
                            label: Column(
                              children: [
                                const Text("Tareas"),
                                Text(
                                  snapshot.data
                                          ?.asMap()
                                          .entries
                                          .map((e) => e.value.reminders.length)
                                          .toList()
                                          .reduce(
                                            (value, element) => value + element,
                                          )
                                          .toString() ??
                                      "",
                                  style: context.getTextTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                          Chip(
                            label: Column(
                              children: [
                                const Text("Completadas"),
                                Text(
                                  snapshot.data
                                          ?.asMap()
                                          .entries
                                          .map((e) => e.value.reminders
                                              .where((element) => element.state)
                                              .length)
                                          .toList()
                                          .reduce(
                                            (value, element) => value + element,
                                          )
                                          .toString() ??
                                      "",
                                  style: context.getTextTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                          Chip(
                            label: Column(
                              children: [
                                const Text("Pendientes"),
                                Text(
                                  snapshot.data
                                          ?.asMap()
                                          .entries
                                          .map((e) => e.value.reminders
                                              .where(
                                                  (element) => !element.state)
                                              .length)
                                          .toList()
                                          .reduce(
                                            (value, element) => value + element,
                                          )
                                          .toString() ??
                                      "",
                                  style: context.getTextTheme.displaySmall,
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              label: SizedBox(
                height: context.getSize.height * 0.3,
                child: SvgPicture.asset("assets/svg/workout.svg"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              backgroundColor: const Color(0xFF61DE93),
              label: SizedBox(
                height: context.getSize.height * 0.3,
                child: FutureBuilder(
                  future: context.read<HomeRepositoryImpl>().getTips(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: snapshot.data?.first["Consejo"] ?? "",
                            style: context.getTextTheme.titleSmall,
                          ),
                        ),
                      );
                    } else {
                      return const CircularProgressIndicator.adaptive();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
