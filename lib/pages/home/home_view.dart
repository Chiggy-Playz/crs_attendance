import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crs_attendance/models/attendance.dart';
import 'package:crs_attendance/models/employee.dart';
import 'package:crs_attendance/pages/attendance/attendance_page.dart';
import 'package:crs_attendance/providers/home/provider.dart';
import 'package:crs_attendance/widgets/colored_bullet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  static const String routePath = "/";
  static const String routeName = "Home";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(calendarControllerProvider);
    return SfCalendar(
      view: CalendarView.month,
      controller: controller,
      showDatePickerButton: true,
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showTrailingAndLeadingDates: false,
        appointmentDisplayCount: 5,
      ),
      appointmentBuilder: (context, details) {
        final Appointment appointment = details.appointments.first;
        final status = AttendanceStatus.values
            .firstWhere((element) => element.name == appointment.notes);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ColoredBullet(
              color: appointment.color,
              size: 12,
            ),
            const SizedBox(width: 12),
            Icon(
              status.icon,
              color: status.color,
              size: details.bounds.height,
            ),
          ],
        );
      },
      timeZone: "Asia/Calcutta",
      dataSource: _MeetingDataSource([]),
      onTap: (calendarTapDetails) {
        context.pushNamed(AttendancePage.routeName, queryParameters: {
          "date": calendarTapDetails.date!.toIso8601String(),
        });
      },
      loadMoreWidgetBuilder: (context, loadMoreAppointments) {
        return FutureBuilder<void>(
          future: loadMoreAppointments(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}

class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }

  @override
  Future<void> handleLoadMore(DateTime startDate, DateTime endDate) async {
    final List<Appointment> meetings = <Appointment>[];
    startDate = DateTime(startDate.year, startDate.month, startDate.day);
    endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);

    final dateWiseMeetings = <DateTime, List<AttendanceModel>>{};

    try {
      // Get all attendances between startDate and endDate
      // Date is stored as utc iso8601 string in firestore
      final QuerySnapshot<Map<String, dynamic>> attendances =
          await FirebaseFirestore.instance
              .collection("attendance")
              .where("date",
                  isGreaterThanOrEqualTo: startDate.toUtc().toIso8601String())
              .where("date",
                  isLessThanOrEqualTo: endDate.toUtc().toIso8601String())
              .get();

      final employeeSnapshot =
          await FirebaseFirestore.instance.collection("employees").get();

      final employees = {
        for (var element in employeeSnapshot.docs
            .map((e) => EmployeeModel.fromJson(e.data())))
          element.id: element
      };

      for (final QueryDocumentSnapshot<Map<String, dynamic>> attendanceRaw
          in attendances.docs) {
        final attendance = AttendanceModel.fromJson(attendanceRaw.data());
        if (attendance.status == AttendanceStatus.choose) {
          continue;
        }
        if (dateWiseMeetings.containsKey(attendance.date)) {
          dateWiseMeetings[attendance.date]!.add(attendance);
        } else {
          dateWiseMeetings[attendance.date] = [attendance];
        }
      }

      // Loop over dateWiseMeetings and add to appointments by sorting the list based on employee name
      for (final date in dateWiseMeetings.keys.toList()..sort()) {
        final attendances = dateWiseMeetings[date]!;
        attendances.sort((a, b) => employees[a.employeeId]!
            .name
            .compareTo(employees[b.employeeId]!.name));
        int i = 0;
        for (final attendance in attendances) {
          final employee = employees[attendance.employeeId]!;
          final appointment = Appointment(
            startTime: attendance.date.add(Duration(hours: i)),
            endTime: attendance.date.add(Duration(hours: i + 1)),
            subject: employee.id,
            color: employee.color,
            notes: attendance.status.name,
            id: attendance.id,
          );
          if (appointments == null || !appointments!.contains(appointment)) {
            meetings.add(appointment);
          }
          i += 1;
        }
      }
    } catch (e) {
      print(e);
    }

    appointments!.addAll(meetings);
    notifyListeners(CalendarDataSourceAction.add, meetings);
  }
}
