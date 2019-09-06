import 'package:flutter/material.dart';

import 'package:iban_form_field/iban_form_field.dart';

class Result extends StatelessWidget {
  final Iban iban;
  Result(this.iban);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(iban.toString())),
    );
  }
}
