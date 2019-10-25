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
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: IbanFormField(
                  onSaved: (iban) => _iban = iban,
                  initialValue: Iban('NL'),
                  autofocus: true,
                  validator: (iban) {
                    if(!iban.isValid) {
                      print(iban);
                      return "This IBAN is not valid";
                    }
                    return null;
                  },
                ),
              ),
              RaisedButton(
                child: Text('show'),
                onPressed: () {
                  if(!_formKey.currentState.validate()) {
                    return;
                  }

                  _formKey.currentState.save();
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(_iban.toString()),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
