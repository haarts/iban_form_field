import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iban_formfield/iban_formfield.dart';

void main() {
  testWidgets('it has a title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: IbanForm('hello')));
    final titleFinder = find.text('hello');

    expect(titleFinder, findsOneWidget);
  });
}
