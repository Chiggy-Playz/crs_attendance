import 'package:crs_attendance/pages/employees/employee_page.dart';
import 'package:crs_attendance/providers/employees/provider.dart';
import 'package:crs_attendance/widgets/color_listtile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
    final employees = ref.watch(employeesProvider);
    return employees.when(
      data: (employees) {
        employees.sort((a, b) => a.name.compareTo(b.name),);
        if (employees.isEmpty) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.group_off, size: 64),
              Gap(16),
              Text('No employees found'),
            ],
          );
        }

        return ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            final employee = employees[index];
            return ColorListTile(
              color: employee.color,
              title: Text(employee.name),
              subtitle: employee.disabled ? const Text('Disabled') : null,
              onTap: () {
                context.pushNamed(
                  EmployeePage.routeName,
                  pathParameters: {'id': employee.id},
                );
              },
            );
          },
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
