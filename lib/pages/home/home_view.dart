import 'package:crs_attendance/providers/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      // appointmentBuilder: (context, calendarAppointmentDetails) {
      //   return Text("AA");
      // },
      monthViewSettings: MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      timeZone: "Asia/Calcutta",
      onTap: (calendarTapDetails) {},
      dataSource: _getCalendarDataSource(),
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    subject: 'Meeting',
    color: Colors.blue,
    startTimeZone: 'Asia/Calcutta',
    endTimeZone: 'Asia/Calcutta',
  ));

  return DataSource(appointments);
}
