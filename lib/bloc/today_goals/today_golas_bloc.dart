import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppk/bloc/today_goals/today_goals_form.dart';
import 'package:ppk/db/daily_task_db/daily_task_db.dart';
import 'package:ppk/db/daily_task_db/daily_task_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ppk/db/user_db/user_db.dart';

import '../../request_constant/request_constant.dart';

part 'today_golas_event.dart';

part 'today_golas_state.dart';

class TodayGoalsBloc extends Bloc<TodayGoalsEvent, TodayGoalsState> {
  TodayGoalsBloc() : super(TodayGoalsState(DateTime.now(), [])) {
    on<TodayGoalsGetDateEvent>(_onCheckCurrebtData);
    on<TodayGoalsOpenTextFieldEvent>(_onOpenTextField);
    on<TodayGoalsCloseTextFieldEvent>(_onCloseTextField);
    on<TodayGoalsChangeDoneStatusEvent>(_onChangeTaskStatus);
    on<TodayGoalsChangeTaskEvent>(_onChangingTask);
    on<TodayGoalsChangeNameTaskEvent>(_onChangeTaskName);
    on<TodayGoalsGetDateAndStatusEvent>(_onCheckCurrentDataWithStatus);
  }


  sortList(List<DailyTask> list) {
    list.sort((a, b) => a.done == b.done
        ? 0
        : a.done == false
            ? -1
            : 1);
    return list;
  }

  _onCheckCurrentDataWithStatus(
      TodayGoalsGetDateAndStatusEvent event, Emitter<TodayGoalsState> emit) async {
    List<DailyTask> goals = sortList(await DatabaseDailyTask.getTasksByDate(event.day));
    goals = <DailyTask>[...goals.where((element) => element.done == event.status).toList()];
    emit(TodayGoalsState(event.day, goals));
  }

  _onCheckCurrebtData(
      TodayGoalsGetDateEvent event, Emitter<TodayGoalsState> emit) async {
    emit(TodayGoalsState(event.day,
        sortList(await DatabaseDailyTask.getTasksByDate(event.day))));
  }

  _onOpenTextField(
      TodayGoalsOpenTextFieldEvent event, Emitter<TodayGoalsState> emit) async {
    emit(TodayGoalsState(
        state.day,
        sortList([
          DailyTask(name: '', done: false, date: state.day),
          ...state.taskList
        ]),
        lastIsNew: true));
  }

  _onCloseTextField(TodayGoalsCloseTextFieldEvent event,
      Emitter<TodayGoalsState> emit) async {
    var tasks = state.taskList;

    if (taskText != null && taskText.length != 0) {
      DailyTask currentTask = DailyTask(name: taskText, done: false, date: state.day);
      var token = await DatabaseUser.getToken();
      if (token.isNotEmpty) {
        var response = await _createTask(currentTask);
        if (response.statusCode == 200) {
          int id = await DatabaseDailyTask.insert(
              DailyTask(name: taskText, done: false, date: state.day, vladId: (jsonDecode(response.body)['id'])));
          tasks[0] =
              DailyTask(name: taskText, done: false, date: state.day, id: id, vladId: (jsonDecode(response.body)['id']));
          emit(TodayGoalsState(state.day, sortList(tasks),
              lastIsNew: false, indexOfChangeingTask: -1));
        }
      } else {
        int id = await DatabaseDailyTask.insert(
            DailyTask(name: taskText, done: false, date: state.day));
        tasks[0] =
            DailyTask(name: taskText, done: false, date: state.day, id: id);
        emit(TodayGoalsState(state.day, sortList(tasks),
            lastIsNew: false, indexOfChangeingTask: -1));
      }
    } else {
      emit(TodayGoalsState(state.day, sortList([...tasks.skip(1)]),
          lastIsNew: false, indexOfChangeingTask: -1));
    }
    form.control('text').value = '';
  }

  _saveTaskToDB(TodayGoalsCloseTextFieldEvent event,
      Emitter<TodayGoalsState> emit) async {
  }

  Future<http.Response>_createTask(DailyTask task) async {
    var token = await DatabaseUser.getToken();
    var headers = JsonContentHeaders(token);
    late http.Response response;
    try{
      response = await http.post(Uri.parse(createTask),
        headers: headers,
        body: json.encode({
          "due_date": DateFormat('yyyy-MM-dd').format(task.date),
          "is_completed": task.done,
          "text": task.name
        }));}
    catch (e){
      response = http.Response.bytes([], 400);
    }
    print(token);
    return response;
  }

  Future<http.Response>_changeTask(DailyTask task) async {
    var token = await DatabaseUser.getToken();
    var headers = JsonContentHeaders(token);
    late http.Response response;
    try{
      response = await http.patch(Uri.parse(createTask + task.vladId.toString()),
          headers: headers,
          body: json.encode({
            "due_date": DateFormat('yyyy-MM-dd').format(task.date),
            "is_completed": task.done,
            "text": task.name
          }));}
    catch (e){
      response = http.Response.bytes([], 400);
    }
    return response;
  }

  _onChangeTaskStatus(TodayGoalsChangeDoneStatusEvent event,
      Emitter<TodayGoalsState> emit) async {
    print('Изменяем статус');
    var tasks = state.taskList;
    tasks[event.index].done = !tasks[event.index].done;
    var response = await _changeTask(tasks[event.index]);
    if(response.statusCode == 200){
      await DatabaseDailyTask.update(tasks[event.index]);
      emit(TodayGoalsState(state.day, sortList(tasks)));
    } else{
      tasks[event.index].done = !tasks[event.index].done;
    }
  }

  _onChangingTask(
      TodayGoalsChangeTaskEvent event, Emitter<TodayGoalsState> emit) async {
    form.control('text').value = state.taskList[event.changingIndex].name;
    emit(TodayGoalsState(state.day, sortList(state.taskList),
        indexOfChangeingTask: event.changingIndex));
  }

  _onChangeTaskName(TodayGoalsChangeNameTaskEvent event,
      Emitter<TodayGoalsState> emit) async {
    var tasks = state.taskList;
    var oldValue = tasks[event.changingIndex].name;
    tasks[event.changingIndex].name = taskText;
    var response = await _changeTask(tasks[event.changingIndex]);
    if(response.statusCode == 200){
      tasks[event.changingIndex].name = taskText;
      emit(TodayGoalsState(state.day, sortList(tasks)));
      await DatabaseDailyTask.update(tasks[event.changingIndex]);
    }
    else{
      tasks[event.changingIndex].name = oldValue;
    }
    form.control('text').value = '';
  }
}
