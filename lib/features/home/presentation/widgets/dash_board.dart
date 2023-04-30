import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mary/app/ui/ui.dart';

import '../../data/data.dart';

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
                width: double.infinity,
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

class HomeDashBoard2 extends StatelessWidget {
  const HomeDashBoard2({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: context.getSize.height * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor: const Color(0x00FFFFFF),
                label: SizedBox(
                  width: double.infinity,
                  child: FutureBuilder<Patient?>(
                    future:
                        context.read<HomeRepositoryImpl>().getPatientById(id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            backgroundColor: const Color(0xFF61DE93),
                            label: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ...snapshot.data!.reminders.asMap().entries.map(
                                  (e) {
                                    return ListTile(
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(e.value.message),
                                          Text(e.value.medication.dosage),
                                          Text(e.value.medication.frequency),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "En: ${e.value.time.difference(DateTime.now()).inMinutes} [minutos]",
                                        ),
                                      ),
                                      leading: e.value.state
                                          ? const Icon(Icons.check)
                                          : const Icon(
                                              Icons.radio_button_unchecked),
                                    );
                                  },
                                ).toList(),
                              ],
                            ),
                          ),
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
                width: double.infinity,
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
                      return const Center(
                          child: SizedBox(
                        height: 50.0,
                        child: CircularProgressIndicator.adaptive(),
                      ));
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
