import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ppk/db/subgoals_db/subGoal_model.dart';
import 'package:ppk/bloc/subgoals/sub_goals_form.dart';

import '../../db/daily_task_db/daily_task_model.dart';
import '../../db/subgoals_db/sub_goals_db.dart';

part 'subgoals_event.dart';
part 'subgoals_state.dart';

class SubGoalsBloc extends Bloc<SubGoals, SubGoalsState> {
  SubGoalsBloc() : super(SubGoalsState('', [])) {
    on<SubGoalsGetDate>(_onCheckCurrentData);
    on<SubGoalsOpenTextField>(_onOpenTextField);
    on<SubGoalsCloseTextField>(_onCloseTextField);
    on<SubGoalsChangeDoneStatus>(_onChangeTaskStatus);
    on<SubGoalsChangeTask>(_onChangingTask);
    on<SubGoalsChangeNameTask>(_onChangeTaskName);
    on<SubGoalsAddExistingGoals>(_addExistingGoals);
  }
  

  sortList(List<SubGoalModel> list){
    list.sort((a, b) => a.isCompleted == b.isCompleted ? 0 : a.isCompleted == false ? -1 : 1);
    return list;
  }

  _addExistingGoals(SubGoalsAddExistingGoals event, Emitter<SubGoalsState> emit){
    var subgoals = event.subgoals.toList();
    emit(SubGoalsState(state.mainGoal, subgoals));
  }

  _onCheckCurrentData(SubGoalsGetDate event, Emitter<SubGoalsState> emit) async {
    // emit(SubGoalsState(event.mainGoal, sortList(await SubGoalsDB.getTasksByMainGoal(event.mainGoal))));
  }

  _onOpenTextField(SubGoalsOpenTextField event, Emitter<SubGoalsState> emit) async {
    emit(SubGoalsState(state.mainGoal,sortList([SubGoalModel(name: '', isCompleted: false, mainGoal: state.mainGoal), ...state.taskList]), lastIsNew: true));
  }

  _onCloseTextField(SubGoalsCloseTextField event, Emitter<SubGoalsState> emit) async {
    var tasks = state.taskList;

    if(taskText != null && taskText.length != 0){
      // int id = await SubGoalsDB.insert(SubGoalModel(name: taskText, isCompleted: false, mainGoal: state.mainGoal));
      tasks[0] = SubGoalModel(name: taskText, isCompleted: false, mainGoal: state.mainGoal);
      emit(SubGoalsState(state.mainGoal,sortList(tasks), lastIsNew: false, indexOfChangeingTask: -1));
    } else{
      emit(SubGoalsState(state.mainGoal,sortList([...tasks.skip(1)]), lastIsNew: false, indexOfChangeingTask: -1));
    }
    form.control('text').value = '';
  }

  _onChangeTaskStatus(SubGoalsChangeDoneStatus event, Emitter<SubGoalsState> emit) async {
    var tasks = state.taskList;
    tasks[event.index].isCompleted = !tasks[event.index].isCompleted;
    emit(SubGoalsState(state.mainGoal,sortList(tasks)));
    // await SubGoalsDB.update(tasks[event.index]);
  }

  _onChangingTask(SubGoalsChangeTask event, Emitter<SubGoalsState> emit) async {
    form.control('text').value = state.taskList[event.changingIndex].name;
    emit(SubGoalsState(state.mainGoal,sortList(state.taskList), indexOfChangeingTask: event.changingIndex));
  }

  _onChangeTaskName(SubGoalsChangeNameTask event, Emitter<SubGoalsState> emit) async {
    var tasks = state.taskList;
    tasks[event.changingIndex].name = taskText;
    emit(SubGoalsState(state.mainGoal,sortList(tasks)));
    // await SubGoalsDB.update(tasks[event.changingIndex]);
    form.control('text').value = '';
  }

}

