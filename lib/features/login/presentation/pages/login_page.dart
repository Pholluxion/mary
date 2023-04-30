import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/login/data/repository/login_repository_impl.dart';
import 'package:mary/features/login/presentation/bloc/login_cubit.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void didChangeDependencies() {
    if (!kIsWeb) {
      if (Platform.isAndroid) {
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission();
      }
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => LoginRepositoryImpl(),
      child: BlocProvider(
        create: (context) => LoginCubit(context.read<LoginRepositoryImpl>()),
        child: const LoginView(),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ResponsiveLayoutBuilder(
        small: _loginFormApp,
        medium: _loginFormTab,
        large: _loginFormWeb,
      ),
    );
  }
}

Widget _loginFormApp(BuildContext context, Widget? child) {
  return const AppLoginForm();
}

Widget _loginFormTab(BuildContext context, Widget? child) {
  return const TabLoginForm();
}

Widget _loginFormWeb(BuildContext context, Widget? child) {
  return const WebLoginForm();
}
