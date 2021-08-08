import 'package:flutter/material.dart';
import 'package:prototype2021/theme/calendar/calendar_handler.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarHandler>(
        create: (_) => CalendarHandler(), child: Column());
  }
}
