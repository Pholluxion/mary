import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:intl/intl.dart';
import 'package:mary/app/ui/ui.dart';

import '../../data/data.dart';

class PatientView extends StatelessWidget {
  const PatientView({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return SingleChildScrollView(
      child: SizedBox(
        width: context.getSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (patient.patientDTO.gender == "M")
              Container(
                  color: const Color(0xFF61DE93),
                  height: 150.0,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: SvgPicture.asset(
                        "assets/svg/he_profile.svg",
                      ),
                    ),
                  ))
            else
              Container(
                color: const Color(0xFF61DE93),
                height: 150.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(
                      "assets/svg/she_profile.svg",
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                label: SizedBox(
                  height: context.getSize.height * 0.3,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "${patient.patientDTO.firstName} ${patient.patientDTO.lastName}",
                        style: context.getTextTheme.titleLarge,
                      ),
                      Text(
                        patient.patientDTO.emailAddress,
                        style: context.getTextTheme.titleMedium,
                      ),
                      Text(
                        dateFormat
                            .format(
                                DateTime.parse(patient.patientDTO.dateOfBirth))
                            .toString(),
                        style: context.getTextTheme.titleMedium,
                      ),
                      Text(
                        patient.patientDTO.gender.getSex(),
                        style: context.getTextTheme.titleMedium,
                      ),
                      Text(
                        patient.patientDTO.phoneNumber,
                        style: context.getTextTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    backgroundColor: const Color(0xFF61DE93),
                    label: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Número de visitas"),
                        Text(
                          patient.medicalVisits.length.toString(),
                          style: context.getTextTheme.displayLarge,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: context.getSize.width * 0.45,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 10.0,
                        children: [
                          ...patient.testResults.asMap().entries.map(
                            (e) {
                              return Chip(
                                backgroundColor: const Color(0xFF61DE93),
                                label: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Text(
                                        e.value.type,
                                        style: context.getTextTheme.bodySmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        e.value.result,
                                        style: context.getTextTheme.titleSmall,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                label: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Historial clinico",
                          style: context.getTextTheme.titleMedium,
                        ),
                      ),
                      ...patient.history.asMap().entries.map(
                        (e) {
                          return Text(
                            "- ${e.value}",
                            style: context.getTextTheme.titleMedium,
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor: const Color(0xFF61DE93),
                label: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Contacto de emergencia"),
                      ),
                      ListTile(
                        title: Text(
                          "Nombre: ${patient.emergencyContact.name}",
                          style: context.getTextTheme.titleMedium,
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Teléfono: ${patient.emergencyContact.phoneNumber}",
                              style: context.getTextTheme.bodySmall,
                            ),
                            Text(
                              "Relación: ${patient.emergencyContact.relationship}",
                              style: context.getTextTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                label: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text("Tratamientos"),
                      ),
                      ...patient.medications.asMap().entries.map(
                        (e) {
                          return ListTile(
                            subtitle: Text(
                              "${e.value.dosage} - ${e.value.frequency}",
                            ),
                            title: Text(e.value.name),
                          );
                        },
                      ).toList(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                backgroundColor: const Color(0xFF61DE93),
                label: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Tareas"),
                    ),
                    ...patient.reminders.asMap().entries.map(
                      (e) {
                        return ListTile(
                          // trailing: Text(
                          //   "En: ${e.value.time.difference(DateTime.now()).inMinutes} [minutos]",
                          // ),
                          subtitle: Text(e.value.medication.dosage),
                          title: Text(e.value.message),
                          leading: e.value.state
                              ? const Icon(Icons.check)
                              : const Icon(Icons.radio_button_unchecked),
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: SizedBox(
                  width: double.infinity,
                  child: TimelineCalendar(
                    calendarType: CalendarType.GREGORIAN,
                    calendarLanguage: "en",
                    calendarOptions: CalendarOptions(
                      viewType: ViewType.DAILY,
                      toggleViewType: true,
                      headerMonthElevation: 10,
                      headerMonthShadowColor: Colors.white,
                      headerMonthBackColor: Colors.white,
                    ),
                    dayOptions: DayOptions(
                      compactMode: true,
                      weekDaySelectedColor: const Color(0xFF61DE93),
                      selectedBackgroundColor: const Color(0xFF61DE93),
                      showWeekDay: true,
                    ),
                    headerOptions: HeaderOptions(
                      weekDayStringType: WeekDayStringTypes.SHORT,
                      monthStringType: MonthStringTypes.FULL,
                      backgroundColor: const Color(0xFF61DE93),
                      calendarIconColor: const Color(0xFFFFFFFF),
                      navigationColor: const Color(0xFFFFFFFF),
                      headerTextColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32.0)
          ],
        ),
      ),
    );
  }
}

extension GetSex on String {
  String getSex() {
    if (this == "M") {
      return "Masculino";
    } else {
      return "Femenino";
    }
  }
}
