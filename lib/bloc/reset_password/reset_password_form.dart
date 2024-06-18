import 'package:reactive_forms/reactive_forms.dart';

class ResetPasswordForm {
  static final form = FormGroup({
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
  });

  static String get email => form.control('email').value ?? 'email null';

  static String get password => form.control('password').value ?? 'password null';
}
