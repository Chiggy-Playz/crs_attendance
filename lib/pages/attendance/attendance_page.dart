import 'package:crs_attendance/config/extensions.dart';
import 'package:crs_attendance/models/attendance.dart';
import 'package:crs_attendance/models/employee.dart';
import 'package:crs_attendance/providers/attendance/provider.dart';
import 'package:crs_attendance/providers/employees/provider.dart';
import 'package:crs_attendance/widgets/color_listtile.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

final entries = AttendanceStatus.values
    .where(
      (status) => status != AttendanceStatus.choose,
    )
    .map(
      (status) => DropdownMenuEntry(
        label: status.name.toCapitalized(),
        value: status,
      ),
    )
    .toList();

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({super.key, required this.date});

  static const String routePath = "/attendance";
  static const String routeName = "Attendance";

  final String date;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  DateTime get _date => DateTime.parse(widget.date).onlyDate();
  String get _formattedDate => "${_date.day}/${_date.month}/${_date.year}";

  bool _isLoading = false;
  bool _showAdvanced = false;
  final _attendances = <AttendanceModel>[];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() => _isLoading = true);

    final attendances =
        await ref.read(attendanceRepositoryProvider).getAttendanceByDate(_date);
    final employees =
        await ref.read(employeeRepositoryProvider).watchEmployees().first;

    for (final employee in employees
      ..sort((a, b) => a.name.compareTo(b.name))) {
      final attendance = attendances.firstWhere(
        (attendance) => attendance.employeeId == employee.id,
        orElse: () => AttendanceModel(
          status: AttendanceStatus.choose,
          employeeId: employee.id,
          date: _date,
        ),
      );

      if (attendance.status == AttendanceStatus.choose && employee.disabled) {
        continue;
      }

      _attendances.add(attendance);
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance for $_formattedDate"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              setState(() => _showAdvanced = !_showAdvanced);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !_isLoading
            ? _attendances.isEmpty
                ? const Center(
                    child: Text("No employees at this time"),
                  )
                : ListView.separated(
                    itemCount: _attendances.length,
                    separatorBuilder: (context, index) => _showAdvanced
                        ? const Divider()
                        : const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final attendance = _attendances[index];

                      return FutureBuilder(
                        future: ref
                            .watch(employeeRepositoryProvider)
                            .getEmployee(attendance.employeeId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          }

                          if (!snapshot.hasData) {
                            return const Text("Employee not found");
                          }

                          final employee = snapshot.data as EmployeeModel;

                          if (!_showAdvanced) {
                            return simpleCard(attendance, employee);
                          }

                          return advancedCard(attendance, employee);
                        },
                      );
                    },
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          ref
              .read(attendanceRepositoryProvider)
              .updateAttendances(_attendances);
          context.pop();
        },
      ),
    );
  }

  Widget simpleCard(AttendanceModel attendance, EmployeeModel employee) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ColorListTile(
        color: employee.color,
        title: Text(employee.name),
        trailing: DropdownMenu<AttendanceStatus>(
          dropdownMenuEntries: entries,
          label: const Text("Status"),
          initialSelection: attendance.status == AttendanceStatus.choose
              ? null
              : attendance.status,
          onSelected: (value) {
            updateAttendance(attendance.id, attendance.copyWith(status: value));
          },
        ),
      ),
    );
  }

  Widget advancedCard(AttendanceModel attendance, EmployeeModel employee) {
    return Column(
      children: [
        ColorListTile(
          color: employee.color,
          title: Text(employee.name),
        ),
        const Gap(8),
        ListTile(
          leading: const Icon(Icons.create),
          title: const Text("Status"),
          trailing: DropdownMenu<AttendanceStatus>(
            dropdownMenuEntries: entries,
            label: const Text("Status"),
            initialSelection: attendance.status == AttendanceStatus.choose
                ? null
                : attendance.status,
            onSelected: (value) {
              updateAttendance(
                  attendance.id, attendance.copyWith(status: value));
            },
          ),
        ),
        const Gap(16),
        TextFormField(
          decoration: const InputDecoration(
            label: Text("Remarks"),
            prefixIcon: Icon(Icons.notes),
          ),
          initialValue: attendance.remarks,
          onChanged: (value) {
            updateAttendance(
                attendance.id, attendance.copyWith(remarks: value));
          },
        ),
        const Gap(16),
        // Line saying "From Select to Select" when timeiN and timeOut are null
        RichText(
          text: TextSpan(
            style: context.textTheme.titleLarge,
            children: [
              const TextSpan(text: "From "),
              TextSpan(
                text: attendance.timeIn == null
                    ? "Select"
                    : attendance.timeIn!.format(context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => updateTime(attendance, "in"),
              ),
              const TextSpan(text: " to "),
              TextSpan(
                text: attendance.timeOut == null
                    ? "Select"
                    : attendance.timeOut!.format(context),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => updateTime(attendance, "out"),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void updateTime(AttendanceModel attendance, String type) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) {
      return;
    }

    setState(() {
      if (type == "in") {
        updateAttendance(attendance.id, attendance.copyWith(timeIn: time));
      } else {
        updateAttendance(attendance.id, attendance.copyWith(timeOut: time));
      }
    });
  }

  void updateAttendance(String id, AttendanceModel updatedAttendance) {
    final index = _attendances.indexWhere((element) => element.id == id);
    _attendances[index] = updatedAttendance;
  }
}
