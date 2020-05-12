import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:iban_form_field/src/input_formatters/spaced_text_input_formatter.dart';

void main() {
  group('adding', () {
    group('characters', () {
      group('at the end', () {
        test("of ''", () {
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

    group('spaces', () {
      group('at the end', () {
        test("of ''", () {
          var oldValue = generate('', 0);
          var newValue = generate(' ', 1);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals(''));
          expect(reformatted.selection.baseOffset, equals(0));
        });
        test("of 'A'", () {
          var oldValue = generate('A', 1);
          var newValue = generate('A ', 2);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('A'));
          expect(reformatted.selection.baseOffset, equals(1));
        });
        test("of 'AAAA'", () {
          var oldValue = generate('AAAA', 4);
          var newValue = generate('AAAA ', 5);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AAAA'));
          expect(reformatted.selection.baseOffset, equals(4));
        });
      });

      group('in the middle', () {
        test("of 'AA'", () {
          var oldValue = generate('AA', 1);
          var newValue = generate('A A', 2);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AA'));
          expect(reformatted.selection.baseOffset, equals(1));
        });

        test("of 'AAAA AA' before first space", () {
          var oldValue = generate('AAAA AA', 4);
          var newValue = generate('AAAA  AA', 5);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AAAA AA'));
          expect(reformatted.selection.baseOffset, equals(4));
        });

        test("of 'AAAA AA' after first space", () {
          var oldValue = generate('AAAA AA', 5);
          var newValue = generate('AAAA  AA', 6);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AAAA AA'));
          expect(reformatted.selection.baseOffset, equals(4));
        });
      });
    });
  });

  group('removing', () {
    group('characters', () {
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
          var oldValue = generate('AAAA A', 6);
          var newValue = generate('AAAA ', 5);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AAAA'));
          expect(reformatted.selection.baseOffset, equals(4));
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
    group('spaces', () {
      // Doesn't apply, well-formed strings don't have spaces at the end
      group('at the end', () {}, skip: true);

      group('in the middle', () {
        test("of 'AAAA AA'", () {
          var oldValue = generate('AAAA AA', 5);
          var newValue = generate('AAAAAA', 4);

          var reformatted = SpacedTextInputFormatter().formatEditUpdate(
            oldValue,
            newValue,
          );

          expect(reformatted.text, equals('AAAA AA'));
          expect(reformatted.selection.baseOffset, equals(4));
        });
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
