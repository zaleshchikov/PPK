import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/goal_screen/global_goals/add_goal/calendar_add_goal.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../bloc/add_goal_model/add_goal_bloc.dart';
import 'add_date.dart';

class NoteBook extends StatefulWidget {
  NoteBook({super.key});

  @override
  State<NoteBook> createState() => _NoteBookState();
}

class _NoteBookState extends State<NoteBook> {
  final form = FormGroup({
    'name': FormControl<String>(),
    'description': FormControl<String>(),
  });

  get name {
    if (form.control('name').isNull) return '';
    return form.control('name').value;
  }

  get description {
    if (form.control('description').isNull) return '';
    return form.control('description').value;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.hoverColor,
      appBar: AppBar(
          backgroundColor: theme.hoverColor,
          leading: Container(
            padding: EdgeInsets.only(left: size.width / 20),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: size.width * 0.08,
                height: size.width * 0.08,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/close_notebook.png'))),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: ReactiveForm(
          formGroup: this.form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                    textAlign: TextAlign.center,
                    'Расскажите про\nсвою цель',
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.textTheme.titleLarge!.color)),
              ),
              Container(height: size.height / 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: size.width / 1,
                    height: size.width * 1.68,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/notebook.png'),
                            fit: BoxFit.fitHeight)),
                    child: Container(
                      padding: EdgeInsets.only(left: size.width / 5),
                      child: ReactiveForm(
                        formGroup: this.form,
                        child: Column(
                          children: [
                            Container(height: size.height / 16),
                            Row(
                              children: [
                                Text('Название',
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme
                                                .textTheme.titleLarge!.color)),
                              ],
                            ),
                            Container(height: size.height / 50),
                            Row(
                              children: [
                                SizedBox(
                                  height: size.height / 10,
                                  width: size.width / 1.3,
                                  child: ReactiveTextField(
                                    cursorColor: Color(0x80292d32),
                                    decoration: InputDecoration(
                                        hintText: 'Придумайте название',
                                        hintStyle: theme.textTheme.bodySmall,
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
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
                                        .copyWith(
                                            color: theme
                                                .textTheme.titleLarge!.color)),
                              ],
                            ),
                            Container(height: size.height / 50),
                            Row(
                              children: [
                                SizedBox(
                                  height: size.height / 5,
                                  width: size.width / 1.3,
                                  child: ReactiveTextField(
                                    cursorColor: Color(0x80292d32),
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                        hintText:
                                            'Добавьте дополнительную\nинформацию про свою цель',
                                        hintStyle: theme.textTheme.bodySmall,
                                        focusedErrorBorder:
                                            OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              width: 0,
                                              color: theme
                                                  .focusColor), //<-- SEE HERE
                                        ),
                                        filled: true,
                                        fillColor: theme.focusColor),
                                    formControlName: 'description',
                                  ),
                                ),
                              ],
                            ),
                            Container(height: size.height / 16),
                            Container(
                              padding: EdgeInsets.only(right: size.width / 10),
                              child: InkWell(
                                onTap: () {
                                  if(name == ''){
                                    form.control('name').setErrors({'Обязательное поле': (error) => 'Обязательное поле'});
                                    form.control('name').markAsTouched();
                                    setState(() {

                                    });
                                  } else{
                                  BlocProvider.of<AddGoalBloc>(context)
                                      .add(AddNameAndText(name, description));
                                  Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (contenxt, animation,
                                        secondaryAnimation) {
                                      // Navigate to the SecondScreen
                                      return BlocProvider.value(
                                        value: BlocProvider.of<AddGoalBloc>(context),
                                        child: AddDate(),
                                      );
                                    },
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;
                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      var offsetAnimation =
                                          animation.drive(tween);
                                      return SlideTransition(
                                        // Apply slide transition
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ));
                                }},
                                child: Center(
                                    child: Container(
                                  width: size.width / 2.1,
                                  height: size.width / 4,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: theme.hintColor,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                    child: Text(
                                      'Сохранить',
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              color: theme
                                                  .textTheme.titleLarge!.color),
                                    ),
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
