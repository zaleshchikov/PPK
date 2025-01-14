import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ppk/UI/welcome/slide_screen.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SuccessReset extends StatelessWidget {
  SuccessReset({super.key});

  final form = FormGroup({
    'email': FormControl<String>(),
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
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
                    Image(
                        height: size.height / 5,
                        image: AssetImage('assets/success_reset_cat.png')),
                    Center(
                      child: Text('Победа!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge),
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'Инструкция успешно отправлена!\nТеперь войдите, используя\nновый пароль.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    ReactiveForm(
                        formGroup: this.form,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[

                            Container(height: size.height / 50),
                            ReactiveFormConsumer(
                              builder: (context, form, child) {
                                return Container(
                                    height: size.height / 10,
                                    width: size.width / 1.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(80),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xff988B8D),
                                              Color(0xff453643)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                    child: Center(
                                      child: Text(
                                        'Войти',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .backgroundColor,
                                                fontWeight: FontWeight.w700),
                                      ),
                                    ));
                              },
                            ),
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
  }
}
