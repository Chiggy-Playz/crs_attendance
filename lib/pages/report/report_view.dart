import 'package:crs_attendance/config/extensions.dart';
import 'package:crs_attendance/models/attendance.dart';
import 'package:crs_attendance/models/employee.dart';
import 'package:crs_attendance/providers/attendance/provider.dart';
import 'package:crs_attendance/providers/employees/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ReportView extends ConsumerStatefulWidget {
  const ReportView({super.key});

  static const String routePath = "/reports";
  static const String routeName = "Reports";

  @override
  ConsumerState<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends ConsumerState<ReportView> {
  EmployeeModel? selectedEmployee;
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    return ref.watch(employeesProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          data: (data) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(8),
                    DropdownMenu(
                      dropdownMenuEntries: data.map((employee) {
                        return DropdownMenuEntry(
                          value: employee,
                          label: employee.name,
                        );
                      }).toList(),
                      label: const Text("Employee"),
                      width: double.infinity,
                      onSelected: (value) {
                        if (value != null) {
                          setState(() {
                            selectedEmployee = value;
                          });
                        }
                      },
                    ),
                    const Gap(8),
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.date_range),
                        title: Text(
                          selectedDateRange == null
                              ? "Choose Date Range"
                              : "Date Range",
                        ),
                        subtitle: selectedDateRange == null
                            ? null
                            : Text(
                                "${selectedDateRange!.start.toFormattedString(DateTimeFormat.date)} - ${selectedDateRange!.end.toFormattedString(DateTimeFormat.date)}",
                              ),
                        onTap: () async {
                          final result = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (result != null) {
                            setState(() {
                              selectedDateRange = result;
                            });
                          }
                        },
                      ),
                    ),
                    const Gap(8),
                    if (selectedEmployee != null && selectedDateRange != null)
                      ref
                          .watch(attendanceByEmployeeProvider(
                              selectedEmployee!.id, selectedDateRange!))
                          .when(
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            error: (error, stackTrace) =>
                                Center(child: Text(error.toString())),
                            data: (attendanceData) {
                              if (attendanceData.isEmpty) {
                                return const Column(
                                  children: [
                                    Icon(
                                      Icons.event_busy,
                                      size: 128,
                                    ),
                                    Text("No data found")
                                  ],
                                );
                              }

                              final counts = <AttendanceStatus, int>{};
                              final appointments = <Appointment>[];

                              for (final attendance in attendanceData) {
                                counts[attendance.status] =
                                    (counts[attendance.status] ?? 0) + 1;
                                appointments.add(
                                  Appointment(
                                    startTime: attendance.date,
                                    endTime:
                                        attendance.date.add(Durations.long1),
                                    color: attendance.status.color,
                                    notes: attendance.status.name,
                                    id: attendance.id,
                                  ),
                                );
                              }

                              return Column(
                                children: <Widget>[
                                  Text(
                                    "Report",
                                    style: context.textTheme.displaySmall,
                                  ),
                                  const Gap(8),
                                  ...AttendanceStatus.values
                                      .where((value) =>
                                          value != AttendanceStatus.choose)
                                      .map((status) {
                                    return Card(
                                      child: ListTile(
                                        leading: Icon(
                                          status.icon,
                                          color: status.color,
                                        ),
                                        title:
                                            Text(status.name.camelToSentence()),
                                        trailing: Text(
                                          "${counts[status] ?? 0}",
                                          style: context.textTheme.bodyMedium,
                                        ),
                                      ),
                                    );
                                  }),
                                  const Gap(16),
                                  Text(
                                    "Calendar View",
                                    style: context.textTheme.displaySmall,
                                  ),
                                  const Gap(8),
                                  SizedBox(
                                    height: 600,
                                    child: SfCalendar(
                                      view: CalendarView.month,
                                      showDatePickerButton: false,
                                      monthViewSettings:
                                          const MonthViewSettings(
                                        appointmentDisplayMode:
                                            MonthAppointmentDisplayMode
                                                .appointment,
                                        showTrailingAndLeadingDates: false,
                                        appointmentDisplayCount: 5,
                                      ),
                                      appointmentBuilder: (context, details) {
                                        final Appointment appointment =
                                            details.appointments.first;
                                        final status = AttendanceStatus.values
                                            .firstWhere((element) =>
                                                element.name ==
                                                appointment.notes);
                                        return Icon(
                                          status.icon,
                                          color: status.color,
                                        );
                                      },
                                      timeZone: "Asia/Calcutta",
                                      dataSource: ReportCalendarDataSource(
                                          appointments),
                                      initialDisplayDate:
                                          selectedDateRange!.start,
                                      minDate: selectedDateRange!.start,
                                      maxDate: selectedDateRange!.end,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        );
  }
}

class ReportCalendarDataSource extends CalendarDataSource {
  ReportCalendarDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) {
    notifyListeners(CalendarDataSourceAction.add, appointments ?? []);
    return super.handleLoadMore(startDate, endDate);
  }
}
