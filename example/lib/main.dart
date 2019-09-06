import 'package:flutter/material.dart';
import 'package:iban_form_field/iban_form_field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter IBAN Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: Center(child: IbanFormField(initialValue: Iban("NL")))),
    );
  }
}
