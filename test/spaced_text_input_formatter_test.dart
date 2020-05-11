import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:iban_form_field/src/input_formatters/spaced_text_input_formatter.dart';

void main() {
  group('adding', () {
    group('at the end', () {
      test('of ' '', () {
        var oldValue = generate('', 0);
        var newValue = generate('B', 1);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('B'));
        expect(reformatted.selection.baseOffset, equals(1));
      });

      test("of 'AAAA'", () {
        var oldValue = generate('AAAA', 4);
        var newValue = generate('AAAAB', 5);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('AAAA B'));
        expect(reformatted.selection.baseOffset, equals(6));
      });
    });

    group('in the middle', () {
      test("of 'AAA'", () {
        var oldValue = generate('AAA', 2);
        var newValue = generate('AABA', 3);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('AABA'));
        expect(reformatted.selection.baseOffset, equals(3));
      });

      test("of 'AAAA'", () {
        var oldValue = generate('AAAA', 2);
        var newValue = generate('AABAA', 3);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('AABA A'));
        expect(reformatted.selection.baseOffset, equals(3));
      });
    });
  });

  group('remove', () {
    group('at the end', () {
      test("of 'A'", () {
        var oldValue = generate('A', 1);
        var newValue = generate('', 0);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals(''));
        expect(reformatted.selection.baseOffset, equals(0));
      });

      test("of 'AAAA A'", () {
        var oldValue = generate('AAAA A', 8);
        var newValue = generate('AAAA ', 6);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('AAAA'));
        expect(reformatted.selection.baseOffset, equals(5));
      });
    });

    group('in the middle', () {
      test("of 'AAAA A'", () {
        var oldValue = generate('AAAA A', 3);
        var newValue = generate('AAA A', 2);

        var reformatted = SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals('AAAA'));
        expect(reformatted.selection.baseOffset, equals(2));
      });
    });
  });
}

TextEditingValue generate(String text, int position) {
  return TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: position),
  );
}
