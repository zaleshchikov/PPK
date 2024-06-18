import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ppk/UI/auth/reset_password.dart';
import 'package:ppk/UI/menu/main_menu.dart';
import 'package:ppk/UI/welcome/slide_screen.dart';
import 'package:ppk/bloc/login/login_bloc.dart';
import 'package:ppk/bloc/login/login_form.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LogIn extends StatelessWidget {
  LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
          child: Builder(builder: (context) {
            return BlocListener<LoginBloc, LoginState>(
  listener: (context, state) {
    if(state.isSuccessRequest) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainMenu()));
    }
  },
  child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/login_back.png'))),
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
                            Container(height: size.height / 40),
                            Center(
                              child: Text('С возвращением!',
                                  style: Theme.of(context).textTheme.titleLarge),
                            ),
                            ReactiveForm(
                                formGroup: LoginForm.form,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      height: size.height / 8,
                                      width: size.width / 1.2,
                                      child: ReactiveTextField(
                                        onChanged: (_) =>
                                            BlocProvider.of<LoginBloc>(context)
                                              ..add(LoginDataEvent(
                                                  password: LoginForm.password,
                                                  email: LoginForm.email)),
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
                                    Container(height: size.height / 30),
                                    Container(
                                      height: size.height / 8,
                                      width: size.width / 1.2,
                                      child: ReactiveTextField(
                                          obscureText: true,
                                        onChanged: (_) =>
                                            BlocProvider.of<LoginBloc>(context)
                                              ..add(LoginDataEvent(
                                                  password: LoginForm.password,
                                                  email: LoginForm.email)),
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
                                          hintStyle: theme.textTheme.bodySmall,
                                          hintText: 'Вспомните пароль ',
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            borderSide: BorderSide(
                                                width: 4,
                                                color: theme.primaryColor
                                                    .withOpacity(
                                                        0.75)), //<-- SEE HERE
                                          ),
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
                                        formControlName: 'password',
                                      ),
                                    ),
                                    Container(height: size.height / 50),
                                    TextButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResetPassword())),
                                      child: Center(
                                        child: Text(
                                          'Забыли пароль?',
                                          style: theme.textTheme.bodySmall,
                                        ),
                                      ),
                                    ),
                                    Container(height: size.height / 50),
                                    BlocBuilder<LoginBloc, LoginState>(
                                        builder: (context, state) {
                                      return ReactiveFormConsumer(
                                        builder: (context, form, child) {
                                          return InkWell(
                                            onTap: () {
                                              BlocProvider.of<LoginBloc>(context)
                                                  .add(SendLoginDataEvent());
                                            },
                                            child: Container(
                                                height: size.height / 9,
                                                width: size.width / 1.2,
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
                                                child: BlocProvider.of<LoginBloc>(
                                                            context)
                                                        .state
                                                        .isLoading
                                                    ? Center(child:
                                                SizedBox( width: 30, height: 30, child: CircularProgressIndicator(color: theme.backgroundColor,)))
                                                    : Center(
                                                        child: Text(
                                                          'Войти',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .backgroundColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      )),
                                          );
                                        },
                                      );
                                    }),
                                    Container(height: size.height / 50),
                                    Center(
                                      child: Image(
                                        image: AssetImage('assets/login_cat.png'),
                                        height: size.height / 6,
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
);
          }));
  }
}
