import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/config/services/notification_service.dart';
import 'package:mary/features/home/data/data.dart';

import '../bloc/home_cubit.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => HomeRepositoryImpl(),
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: const _HomeLayout(),
      ),
    );
  }
}

class _HomeLayout extends StatelessWidget {
  const _HomeLayout();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context
          .read<HomeRepositoryImpl>()
          .getPatientLogin(FirebaseAuth.instance.currentUser!.email!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!["rol"] == 0) {
            return HomeViewPatient(id: snapshot.data!["patient"]);
          } else if (snapshot.data!["rol"] == 1) {
            return HomeViewCare(id: snapshot.data!["patient"]);
          } else {
            return const HomeViewDoc();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class HomeViewDoc extends StatefulWidget {
  const HomeViewDoc({super.key});

  @override
  State<HomeViewDoc> createState() => _HomeViewDocState();
}

class _HomeViewDocState extends State<HomeViewDoc> {
  late final NotificationService notificationService;
  @override
  void initState() {
    notificationService = NotificationService();
    listenToNotificationStream();
    notificationService.initializePlatformNotifications();

    super.initState();
  }

  void listenToNotificationStream() =>
      notificationService.behaviorSubject.listen((payload) {
        context.go("/notify");
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: context.inversePrimaryColor,
            actions: [
              IconButton(
                onPressed: () async {
                  await notificationService.showLocalNotification(
                    id: 0,
                    title: "Notificaciones activadas",
                    body:
                        "¡Excelente! Has activado las notificaciones locales. Ahora estarás al tanto de las actualizaciones importantes en tu aplicación. ¡No te pierdas ninguna novedad!",
                    payload:
                        "¡Excelente! Has activado las notificaciones locales. Ahora estarás al tanto de las actualizaciones importantes en tu aplicación. ¡No te pierdas ninguna novedad!",
                  );

                  await notificationService.showScheduledLocalNotification(
                    id: 1,
                    title: "Tomar tramadol",
                    body:
                        "¡Hora de tomar tus medicamentos con un poco de agua!",
                    payload:
                        "¡Hora de tomar tus medicamentos con un poco de agua!",
                    seconds: 10,
                  );
                },
                icon: const Icon(Icons.notification_add),
              ),
            ],
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
                  : (state.homeOption == HomeOption.add)
                      ? const AddLoginForm()
                      : const PatientsView(),
          floatingActionButton: (state.homeOption == HomeOption.patients)
              ? FloatingActionButton(
                  onPressed: context.read<HomeCubit>().addPage,
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}

class HomeViewPatient extends StatelessWidget {
  const HomeViewPatient({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.inversePrimaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().whenComplete(
                          () => context.go("/login"),
                        );
                  },
                  icon: const Icon(Icons.exit_to_app),
                ),
              )
            ],
          ),
          body: HomeDashBoard2(id: id),
        );
      },
    );
  }
}

class HomeViewCare extends StatelessWidget {
  const HomeViewCare({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: context.inversePrimaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut().whenComplete(
                          () => context.go("/login"),
                        );
                  },
                  icon: const Icon(Icons.exit_to_app),
                ),
              )
            ],
          ),
          body: HomeDashBoard2(id: id),
        );
      },
    );
  }
}
