import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MultipleDateSelection extends StatefulWidget {
  final Set<DateTime> selectedDates;

  const MultipleDateSelection({Key? key, required this.selectedDates}) : super(key: key);

  @override
  _MultipleDateSelectionState createState() => _MultipleDateSelectionState();
}

class _MultipleDateSelectionState extends State<MultipleDateSelection> {
  late Set<DateTime> _tempSelectedDates;

  @override
  void initState() {
    super.initState();
    _tempSelectedDates = widget.selectedDates.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: TableCalendar(
        locale: 'pt_BR',
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        focusedDay: DateTime.now(),
        selectedDayPredicate: (day) => _tempSelectedDates.contains(day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            if (_tempSelectedDates.contains(selectedDay)) {
              _tempSelectedDates.remove(selectedDay);
            } else {
              _tempSelectedDates.add(selectedDay);
            }
          });
        },
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: const Color.fromARGB(220, 105, 126, 80),
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.orangeAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
