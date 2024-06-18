import 'package:reactive_forms/reactive_forms.dart';

final form = FormGroup ({
  'text': FormControl<String>(),
});

get taskText => form.control('text').value;