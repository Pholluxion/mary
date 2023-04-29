import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:mary/app/ui/ui.dart';

import 'package:mary/features/login/presentation/bloc/login_cubit.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.getSize.height,
        minWidth: context.getSize.width,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.getPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _TextLogin(),
            _EmailInput(),
            _PasswordInput(),
            _LoginButton(),
            _HelpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends HookWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.getPadding),
          child: TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              label: const Text("Correo electrónico"),
              errorText: state.emailErrorMessage.isEmpty
                  ? null
                  : state.emailErrorMessage,
            ),
            onChanged: context.read<LoginCubit>().setEmail,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends HookWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    final oscurePassword = useValueNotifier<bool>(true);
    final passwordController = useTextEditingController();
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.getPadding),
          child: ValueListenableBuilder(
            valueListenable: oscurePassword,
            builder: (context, value, child) {
              return TextFormField(
                controller: passwordController,
                obscureText: value,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  label: const Text("Contraseña"),
                  errorText: state.passwordErrorMessage.isEmpty
                      ? null
                      : state.passwordErrorMessage,
                  suffixIcon: IconButton(
                    onPressed: () => oscurePassword.value = !value,
                    icon: const Icon(Icons.remove_red_eye),
                  ),
                ),
                onChanged: context.read<LoginCubit>().setPassword,
              );
            },
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.getPadding),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.succes) {
            context.go('/home');
          }
          if (state.status == LoginStatus.error) {
            showSimpleSnackBar(context: context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.validForm
                ? context.read<LoginCubit>().loginWithEmailAndPassword
                : null,
            child: Padding(
              padding: EdgeInsets.all(context.getPadding),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Builder(builder: (context) {
                    if (state.status == LoginStatus.loading) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return Text(
                        "Iniciar sesión",
                        style: context.getTextTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HelpButton extends StatelessWidget {
  const _HelpButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.getPadding),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "¿Necesitas ayuda? ",
              style: context.getTextTheme.labelLarge,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Click aquí",
                style: TextStyle(
                  fontSize: context.getTextTheme.labelLarge!.fontSize,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TextLogin extends StatelessWidget {
  const _TextLogin();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.getPadding),
      child: Text(
        "Iniciar sesión",
        style: context.getTextTheme.displaySmall?.copyWith(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
