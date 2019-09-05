import 'package:flutter/material.dart';

class IbanForm extends StatefulWidget {
  final String title;
  IbanForm(this.title);

  @override
  State<StatefulWidget> createState() => _IbanState();
}

class _IbanState extends State<IbanForm> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      	Text(widget.title),
      	Text(widget.title),
      	Text(widget.title),
      ],
    );
  }
}
