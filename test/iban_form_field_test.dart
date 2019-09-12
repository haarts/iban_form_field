import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iban_form_field/iban_form_field.dart';

void main() {
  testWidgets('it has a country code', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IbanFormField(
            initialValue: Iban('NL'),
          ),
        ),
      ),
    );
    final countryCodeFinder = find.text('NL');

    expect(countryCodeFinder, findsOneWidget);
  });

  testWidgets('it shifts focus', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IbanFormField(),
        ),
      ),
    );

    final countryCodeFinder = find.byKey(Key('country-code'));
    await tester.enterText(countryCodeFinder, 'N');
    await tester.enterText(countryCodeFinder, 'L');
    await tester.pump();
    final focusNodesFinder = find.byType(FocusNode);
    expect(focusNodesFinder, findsNWidgets(3));
    // expect((focusNodesFinder.at(1).evaluate().single.widget as FocusNode).hasPrimaryFocus, isTrue);
  });
}
