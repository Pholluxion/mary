import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mary/features/home/presentation/bloc/home_cubit.dart';

import '../../data/data.dart';

class PatientsView extends HookWidget {
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    return FutureBuilder<List<Patient>>(
      future: context.read<HomeRepositoryImpl>().getPatients(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Patient> patients = snapshot.data ?? [];
          return ValueListenableBuilder(
            valueListenable: searchController,
            builder: (context, value, child) {
              if (searchController.text.isNotEmpty) {
                patients = snapshot.data ?? [];
                patients = patients
                    .where((element) => element.patientDTO.firstName
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase()))
                    .toList();
              } else {
                patients = snapshot.data ?? [];
              }
              return CustomScrollView(
                slivers: <Widget>[
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      minHeight: 100.0,
                      maxHeight: 100.0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Icon(Icons.search),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              label: const Text("Buscar"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SliverPadding(
                    padding: EdgeInsets.all(2.0),
                  ),
                  SliverFixedExtentList(
                    itemExtent: 80,
                    delegate: SliverChildListDelegate(
                      [
                        ...patients
                            .asMap()
                            .entries
                            .map(
                              (e) => ListTile(
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
                                  context
                                      .read<HomeCubit>()
                                      .setPatientPage(e.value);
                                },
                              ),
                            )
                            .toList()
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
