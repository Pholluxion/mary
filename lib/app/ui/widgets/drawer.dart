import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/home/presentation/bloc/home_cubit.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: context.cardColor,
      child: ListView(
        children: [
          GestureDetector(
            onTap: () {
              context.read<HomeCubit>().setHomePage();
              context.pop();
            },
            child: const DrawerHeader(
              child: SizedBox(
                width: double.infinity,
                child: MaryLogo(),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              context.read<HomeCubit>().setHomePage();
              context.pop();
            },
            leading: const Icon(Icons.bar_chart_sharp),
            title: Text(
              "Dashboard",
              style: context.getTextTheme.titleMedium,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              "Mis pacientes",
              style: context.getTextTheme.titleMedium,
            ),
            onTap: () {
              context.read<HomeCubit>().setPatientsPage();
              context.pop();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48.0),
            child: ListTile(
                leading: const Icon(Icons.logout),
                title: Text(
                  "Cerrar sesión",
                  style: context.getTextTheme.titleMedium,
                ),
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut().whenComplete(
                          () => context.go("/login"),
                        );
                  } catch (e) {
                    throw Exception();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
