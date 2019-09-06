import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:iban_form_field/iban_form_field.dart';

void main() {
  group("adding", () {
    group("at the end", () {
      test("of ''", () {
        TextEditingValue oldValue = generate("", 0);
        TextEditingValue newValue = generate("B", 1);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("B"));
        expect(reformatted.selection.baseOffset, equals(1));
      });

      test("of 'AAAA'", () {
        TextEditingValue oldValue = generate("AAAA", 4);
        TextEditingValue newValue = generate("AAAAB", 5);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("AAAA B"));
        expect(reformatted.selection.baseOffset, equals(6));
      });
    });

    group("in the middle", () {
      test("of 'AAA'", () {
        TextEditingValue oldValue = generate("AAA", 2);
        TextEditingValue newValue = generate("AABA", 3);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("AABA"));
        expect(reformatted.selection.baseOffset, equals(3));
      });

      test("of 'AAAA'", () {
        TextEditingValue oldValue = generate("AAAA", 2);
        TextEditingValue newValue = generate("AABAA", 3);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("AABA A"));
        expect(reformatted.selection.baseOffset, equals(3));
      });
    });
  });

  group("remove", () {
    group("at the end", () {
      test("of 'A'", () {
        TextEditingValue oldValue = generate("A", 1);
        TextEditingValue newValue = generate("", 0);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals(""));
        expect(reformatted.selection.baseOffset, equals(0));
      });

      test("of 'AAAA A'", () {
        TextEditingValue oldValue = generate("AAAA A", 8);
        TextEditingValue newValue = generate("AAAA ", 6);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("AAAA"));
        expect(reformatted.selection.baseOffset, equals(5));
      });
    });

    group("in the middle", () {
      test("of 'AAAA A'", () {
        TextEditingValue oldValue = generate("AAAA A", 3);
        TextEditingValue newValue = generate("AAA A", 2);

        TextEditingValue reformatted =
            SpacedTextInputFormatter().formatEditUpdate(
          oldValue,
          newValue,
        );

        expect(reformatted.text, equals("AAAA"));
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

