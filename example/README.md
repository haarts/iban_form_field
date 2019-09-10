Using the widget is easy:

```
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: IbanFormField(
                onSaved: (iban) => _iban = iban,
                initialValue: Iban('NL'),
              ),
            ),
            RaisedButton(
              child: Text('show'),
              onPressed: () {
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
    );
  }
}
```
