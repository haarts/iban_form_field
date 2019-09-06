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

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IbanFormField(
          initialValue: Iban("NL"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Result(
                Iban('NL'),
              ),
            ),
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
