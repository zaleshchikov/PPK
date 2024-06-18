import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/bloc/add_goal_model/global_goal_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';
import '../add_goal/add_date.dart';

class ChangeGoalNote extends StatefulWidget {

  ChangeGoalNote({super.key});

  @override
  State<ChangeGoalNote> createState() => _ChangeGoalNoteState();
}

class _ChangeGoalNoteState extends State<ChangeGoalNote> {

  final form = FormGroup({
    'name': FormControl<String>(),
    'description': FormControl<String>(),
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);


    return BlocBuilder<AddGoalBloc, GlobalGoalModel>(
  builder: (context, state) {
    form.control('name').value = state.name;
    form.control('description').value = state.text;
    return Container(
      width: size.width ,
      height: size.height /2.3,
      child: Container(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: [
              Row(
                children: [
                  Text('Название',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: theme.textTheme.titleLarge!.color)),
                ],
              ),
              Container(height: size.height / 50),
              Row(
                children: [
                  SizedBox(
                    height: size.height / 10,
                    width: size.width / 1.3,
                    child: ReactiveTextField(
                      onChanged: (_){
                        BlocProvider.of<AddGoalBloc>(context).add(AddNameAndText(form.control('name').value ?? '', form.control('description').value ?? ''));
                      },
                      cursorColor: Color(0x80292d32),
                      decoration: InputDecoration(
                          hintText: 'Придумайте название',
                          hintStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          filled: true,
                          fillColor: theme.focusColor),
                      formControlName: 'name',
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Описание',
                      style: theme.textTheme.titleMedium!
                          .copyWith(color: theme.textTheme.titleLarge!.color)),
                ],
              ),
              Container(height: size.height / 50),
              Row(
                children: [
                  SizedBox(
                    height: size.height / 6,
                    width: size.width / 1.3,
                    child: ReactiveTextField(
                      cursorColor: Color(0x80292d32),
                      maxLines: 3,
                      onChanged: (_){
                        BlocProvider.of<AddGoalBloc>(context).add(AddNameAndText(form.control('name').value ?? '', form.control('description').value ?? ''));
                      },
                      decoration: InputDecoration(
                          hintText:
                              'Добавьте дополнительную\nинформацию про свою цель',
                          hintStyle: theme.textTheme.bodySmall,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 0,
                                color: theme.focusColor), //<-- SEE HERE
                          ),
                          filled: true,
                          fillColor: theme.focusColor),
                      formControlName: 'description',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
