import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/home/presentation/bloc/home_cubit.dart';

import '../../data/data.dart';

class AddLoginForm extends StatelessWidget {
  const AddLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                _RolBox(),
                SizedBox(height: 16.0),
                _LoginButton(),
                SizedBox(height: 16.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TextLogin extends StatelessWidget {
  const _TextLogin();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Crear usuario",
        style: context.getTextTheme.titleLarge?.copyWith(
          color: const Color(0xFF61DE93),
        ),
      ),
    );
  }
}

class _RolBox extends StatelessWidget {
  const _RolBox();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text("Paciente"),
                Text("Cuidador"),
              ],
            ),
            Center(
              child: SizedBox(
                width: context.getSize.width * 0.3,
                child: Slider(
                  min: 0.0,
                  max: 1.0,
                  divisions: 1,
                  label: "Rol",
                  value: state.rol.toDouble(),
                  onChanged: (v) {
                    context.read<HomeCubit>().setRol(v.toInt());
                  },
                ),
              ),
            ),
            state.rol == 1 ? const _PatientInput() : const SizedBox(),
          ],
        );
      },
    );
  }
}

class _EmailInput extends HookWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    return BlocBuilder<HomeCubit, HomeState>(
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
              onChanged: context.read<HomeCubit>().setEmail,
            ),
          ),
        );
      },
    );
  }
}

class _PatientInput extends HookWidget {
  const _PatientInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(context.getPadding),
          child: Container(
            height: context.getSize.width,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: FutureBuilder<List<Patient>>(
              future: context.read<HomeRepositoryImpl>().getPatients(),
              builder: (context, snapshot) {
                List<Patient> patients = snapshot.data ?? [];
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      ...patients
                          .asMap()
                          .entries
                          .map(
                            (e) => Container(
                              color: (state.patient?.patientDTO.id ==
                                      e.value.patientDTO.id)
                                  ? const Color(0xFF61DE93)
                                  : const Color(0x00FFFFFF),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                  child: e.value.patientDTO.gender == "M"
                                      ? SvgPicture.asset(
                                          "assets/svg/he_profile.svg")
                                      : SvgPicture.asset(
                                          "assets/svg/she_profile.svg"),
                                ),
                                title: Text(
                                    "${e.value.patientDTO.firstName}  ${e.value.patientDTO.lastName}"),
                                subtitle: Text(e.value.patientDTO.emailAddress),
                                trailing: const Icon(Icons.more_vert),
                                onTap: () {
                                  context.read<HomeCubit>().setPatient(e.value);
                                },
                              ),
                            ),
                          )
                          .toList()
                    ],
                  );
                } else {
                  return const Text("No hay registro de pacientes.");
                }
              },
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
    return BlocBuilder<HomeCubit, HomeState>(
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
                  onChanged: context.read<HomeCubit>().setPassword,
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
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state.status == Status.succes) {
            context.read<HomeCubit>().setPatientsPage();
          }
        },
        builder: (context, state) {
          return ElevatedButton(
            onPressed: state.validForm
                ? context.read<HomeCubit>().addloginWithEmailAndPassword
                : null,
            child: Padding(
              padding: EdgeInsets.all(context.getPadding),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Builder(builder: (context) {
                    if (state.status == Status.loading) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return const Text(
                        "Crear usuario",
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
