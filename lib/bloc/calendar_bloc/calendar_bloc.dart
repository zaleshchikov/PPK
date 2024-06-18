import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(CalendarState(DateTime.now())) {
    on<CalendarEvent>(_onChangeDay);
  }

  _onChangeDay(CalendarEvent event, Emitter<CalendarState> emit){
    emit(CalendarState(event.today));
  }
}
