import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/login/data/repository/login_repository_impl.dart';
import 'package:mary/features/login/presentation/bloc/login_cubit.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
