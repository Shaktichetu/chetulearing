import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({Key? key}) : super(key: key);

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  final format = DateFormat("yyyy-MM-dd hh:mm a");
  DateTime? _startDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date Time Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: DateTimeField(
          format: format,
          onShowPicker: (context, currentValue) async {
            final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              _startDate = DateTimeField.combine(date, time);
              debugPrint(_startDate.toString());
              return DateTimeField.combine(date, time);
            } else {
              return currentValue;
            }
          },
        ),
      ),
    );
  }
}
