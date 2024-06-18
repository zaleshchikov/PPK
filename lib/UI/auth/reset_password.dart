import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/bloc/reset_password/reset_password_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:ppk/bloc/reset_password/reset_password_form.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider<ResetPasswordBloc>(
        create: (context) => ResetPasswordBloc(),
        child: Builder(builder: (context) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/reset_password_back.png'))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(height: size.height / 15),
                    Row(
                      children: [
                        Container(width: size.width / 20),
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: ImageIcon(
                              AssetImage('assets/button back.png'),
                              size: size.height / 15,
                            )),
                      ],
                    ),
                    Container(height: size.height / 50),
                    Container(
                      height: size.height / 1.2,
                      decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100),
                            topLeft: Radius.circular(100),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text('Восстановление\nпароля',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              'Не переживайте!\nМы вышлем на почту инструкцию\nдля сброса пароля.',
                              style: theme.textTheme.bodySmall,
                            ),
                          ),
                          ReactiveForm(
                              formGroup: ResetPasswordForm.form,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: size.height / 8,
                                    width: size.width / 1.2,
                                    child: ReactiveTextField(
                                      onChanged: (_) =>
                                          BlocProvider.of<ResetPasswordBloc>(context)
                                            ..add(ResetPasswordDataEvent(
                                                password:
                                                    ResetPasswordForm.password)),
                                      validationMessages: {
                                        ValidationMessage.required: (error) =>
                                            'Обязательное поле',
                                        ValidationMessage.email: (error) =>
                                            'Почта должна быть почтой',
                                      },
                                      cursorColor:
                                          Theme.of(context).primaryColor,
                                      style: theme.textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              width: 4,
                                              color: theme.errorColor
                                                  .withOpacity(
                                                      0.75)), //<-- SEE HERE
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              width: 4,
                                              color: theme.errorColor
                                                  .withOpacity(
                                                      0.75)), //<-- SEE HERE
                                        ),
                                        hintStyle: theme.textTheme.bodySmall,
                                        hintText: 'Введите свою почту',
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              width: 4,
                                              color: theme.primaryColor
                                                  .withOpacity(
                                                      0.75)), //<-- SEE HERE
                                        ),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              width: 4,
                                              color: theme.primaryColor
                                                  .withOpacity(
                                                      0.75)), //<-- SEE HERE
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: BorderSide(
                                              width: 4,
                                              color: theme.primaryColor
                                                  .withOpacity(
                                                      0.75)), //<-- SEE HERE
                                        ),
                                      ),
                                      formControlName: 'email',
                                    ),
                                  ),
                                  Container(height: size.height / 50),
                                  BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                                      builder: (context, state) {
                                    return ReactiveFormConsumer(
                                      builder: (context, form, child) {
                                        return InkWell(
                                          onTap: () {
                                            BlocProvider.of<ResetPasswordBloc>(
                                                context).add(SendResetPasswordDataEvent());
                                          },
                                          child: Container(
                                              height: size.height / 10,
                                              width: size.width / 1.4,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(80),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xff988B8D),
                                                        Color(0xff453643)
                                                      ],
                                                      begin:
                                                          Alignment.centerLeft,
                                                      end: Alignment
                                                          .centerRight)),
                                              child: BlocProvider.of<ResetPasswordBloc>(
                                                  context)
                                                  .state
                                                  .isLoading
                                                  ? Center(child:
                                              SizedBox( width: 30, height: 30, child: CircularProgressIndicator(color: theme.backgroundColor,)))
                                                  : Center(
                                                child: Text(
                                                  'Отправить',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .backgroundColor,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                ),
                                              )),
                                        );
                                      },
                                    );
                                  }),
                                  Container(height: size.height / 7),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
