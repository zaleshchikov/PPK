import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/bloc/add_goal_model/add_goal_bloc.dart';
import 'package:ppk/bloc/calendar_bloc/calendar_bloc.dart';
import 'package:ppk/bloc/today_goals/today_golas_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarAddGoal extends StatelessWidget {
  const CalendarAddGoal({super.key});

  static monthNumberToName(int number) {
    switch (number) {
      case 1:
        return 'Января';
      case 2:
        return 'Февраля';
      case 3:
        return 'Марта';
      case 4:
        return 'Апреля';
      case 5:
        return 'Мая';
      case 6:
        return 'Июня';
      case 7:
        return 'Июля';
      case 8:
        return 'Августа';
      case 9:
        return 'Сентебря';
      case 10:
        return 'Октября';
      case 11:
        return 'Ноября';
      case 12:
        return 'Декабря';
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return FittedBox(
        fit: BoxFit.fitWidth,
        child: Container(
            width: size.width * 2,
            height: size.height / 1.2,
            decoration: BoxDecoration(
                color: theme.backgroundColor,
                borderRadius: BorderRadius.circular(50)),
            child: SizedBox(
              width: size.width / 1.2,
              child: BlocBuilder<CalendarBloc, CalendarState>(
                  builder: (context, state) {
                    return TableCalendar(
                      onDaySelected: (day, focusedDay){
                        BlocProvider.of<CalendarBloc>(context)
                            .add(CalendarEvent(day));
                        BlocProvider.of<AddGoalBloc>(context).add(AddDateGoal(day));
                      },
                      selectedDayPredicate: (day) => isSameDay(day, BlocProvider.of<CalendarBloc>(context).state.today),
                      focusedDay: BlocProvider.of<CalendarBloc>(context).state.today,
                      locale: 'ru_RU',
                      daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: theme.textTheme.titleLarge!
                              .copyWith(color: theme.hoverColor),
                          weekdayStyle: theme.textTheme.titleLarge!
                              .copyWith(color: theme.hoverColor)),
                      daysOfWeekHeight: size.height / 15,
                      rowHeight: 100,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      headerStyle: HeaderStyle(
                        titleTextFormatter: (day, f) {
                          return "${BlocProvider.of<CalendarBloc>(context).state.today.day} " + monthNumberToName(BlocProvider.of<CalendarBloc>(context).state.today.month);
                        },
                        rightChevronPadding: EdgeInsets.only(
                            top: size.width / 10, right: size.width / 10),
                        leftChevronPadding: EdgeInsets.only(
                            top: size.width / 10, left: size.width / 10),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          size: size.height / 15,
                        ),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          size: size.height / 15,
                        ),
                        titleTextStyle: theme.textTheme.titleLarge!,
                        titleCentered: true,
                        formatButtonVisible: false,
                      ),
                      calendarStyle: CalendarStyle(
                        rangeStartTextStyle: theme.textTheme.titleLarge!,
                        rangeEndTextStyle: theme.textTheme.titleLarge!,
                        outsideTextStyle: theme.textTheme.titleLarge!,
                        todayTextStyle: theme.textTheme.titleLarge!,
                        defaultTextStyle: theme.textTheme.titleLarge!,
                        holidayTextStyle: theme.textTheme.titleLarge!,
                        weekNumberTextStyle: theme.textTheme.titleLarge!,
                        weekendTextStyle: theme.textTheme.titleLarge!,
                        todayDecoration: BoxDecoration(
                          color: theme.backgroundColor,
                          shape: BoxShape.circle,
                        ),
                        selectedTextStyle: theme.textTheme.titleLarge!,
                        selectedDecoration: BoxDecoration(
                          color: theme.dialogBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      calendarFormat: CalendarFormat.month,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                    );
                  }),
            )));
  }
}
