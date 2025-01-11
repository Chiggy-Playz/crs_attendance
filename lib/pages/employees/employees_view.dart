import 'package:crs_attendance/providers/employees/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

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
            return ListTile(
              leading: Container(
                decoration: BoxDecoration(
                  color: employee.color,
                  shape: BoxShape.circle,
                ),
                width: 32,
              ),
              title: Text(employee.name),
            );
          },
        );
      },
      error: (error, stack) => Center(child: Text('Error: $error')),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
