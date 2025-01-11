import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeesView extends ConsumerStatefulWidget {
  const EmployeesView({super.key});

  static const String routePath = "/employees";
  static const String routeName = "Employees";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmployeesViewState();
}

class _EmployeesViewState extends ConsumerState<EmployeesView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
