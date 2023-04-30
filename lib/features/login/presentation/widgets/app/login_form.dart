import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:mary/app/ui/ui.dart';

import '../../bloc/bloc.dart';

class AppLoginForm extends StatelessWidget {
  const AppLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) =>
            current.loginForm != previous.loginForm,
        builder: (context, state) {
          if (state.loginForm == LoginForm.login) {
            return const _LoginForm();
          } else {
            return const _RecoveryForm();
          }
        },
      ),
    );
  }
}

class _RecoveryForm extends StatelessWidget {
  const _RecoveryForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.getSize.height,
        minWidth: context.getSize.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MaryLogo(),
          const _TextLogin(),
          Card(
            elevation: 0,
            margin: EdgeInsets.all(context.getPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 16.0),
                _EmailInput(),
                SizedBox(height: 16.0),
                _RecoveryButton(),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          const _HelpButton(),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: context.getSize.height,
        minWidth: context.getSize.width,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const MaryLogo(),
          const _TextLogin(),
          Card(
            elevation: 0,
            margin: EdgeInsets.all(context.getPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 16.0),
                _EmailInput(),
                _PasswordInput(),
                _RecoveryPassword(),
                SizedBox(height: 16.0),
                _LoginButton(),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          const _HelpButton(),
        ],
      ),
    );
  }
}

class _RecoveryPassword extends StatelessWidget {
  const _RecoveryPassword();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.getPadding),
      child: TextButton(
        onPressed: context.read<LoginCubit>().updateForm,
        child: const Text("Recuperar contraseña"),
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
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(Icons.email),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                label: const Text("Correo electrónico"),
                errorText: state.emailErrorMessage.isEmpty
                    ? null
                    : state.emailErrorMessage,
              ),
              onChanged: context.read<LoginCubit>().setEmail,
            ),
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
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: value,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(Icons.password),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    label: const Text("Contraseña"),
                    errorText: state.passwordErrorMessage.isEmpty
                        ? null
                        : state.passwordErrorMessage,
                    suffixIcon: IconButton(
                      onPressed: () => oscurePassword.value = !value,
                      icon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: value
                            ? const Icon(Icons.remove_red_eye)
                            : const Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                  ),
                  onChanged: context.read<LoginCubit>().setPassword,
                ),
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
            context.go('/');
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
                      return const Text(
                        "Iniciar sesión",
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

class _RecoveryButton extends StatelessWidget {
  const _RecoveryButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.getPadding),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.error) {
            showSimpleSnackBar(context: context, message: state.errorMessage);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              ElevatedButton(
                onPressed: state.email.isNotEmpty
                    ? context.read<LoginCubit>().recoveryPassword
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
                          return const Text(
                            "Enviar correo de recuperación",
                          );
                        }
                      }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.getPadding),
              ElevatedButton(
                onPressed: context.read<LoginCubit>().setLoginForm,
                child: Padding(
                  padding: EdgeInsets.all(context.getPadding),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Builder(
                        builder: (context) {
                          return const Text(
                            "Volver",
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
              onPressed: () {
                showSimpleSnackBar(
                  context: context,
                  message: "Esta función aún no está disponible. :(",
                );
              },
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
          color: const Color(0xFF61DE93),
        ),
      ),
    );
  }
}
