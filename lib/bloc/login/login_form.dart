import 'package:reactive_forms/reactive_forms.dart';

class LoginForm {
  static final form = FormGroup({
    'password': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
  });

  static String get email => form.control('email').value ?? 'email null';

  static String get password => form.control('password').value ?? 'password null';
}
