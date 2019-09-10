import 'package:flutter/material.dart';
import 'package:iban_form_field/iban_form_field.dart';

import 'package:example/result.dart';

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
        home: Example());
  }
}

final _formKey = GlobalKey<FormState>();

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  Iban _iban;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: IbanFormField(
            onSaved: (iban) => _iban = iban,
            initialValue: Iban('NL'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _formKey.currentState.save();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Result(
                _iban,
              ),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
