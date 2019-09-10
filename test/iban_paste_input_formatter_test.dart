import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:iban_form_field/src/input_formatters/iban_paste_input_formatter.dart';

void main() {
  final TextEditingController countryCode = TextEditingController();
  final TextEditingController checkDigits = TextEditingController();
  final TextEditingController basicBankAccountNumber = TextEditingController();

	group('paste in country code', () {
    test('paste an IBAN without spaces', () {
      TextEditingValue oldValue = generate("", 0);
      TextEditingValue newValue = generate("NL09ABNA6775613067", 2);

      TextEditingValue reformatted = IbanPasteInputFormatter.countryCode(
        checkDigits,
        basicBankAccountNumber,
      ).formatEditUpdate(
        oldValue,
        newValue,
      );

      expect(reformatted.text, equals("NL"));
      expect(reformatted.selection.baseOffset, equals(2));
      expect(checkDigits.text, equals("09"));
      expect(basicBankAccountNumber.text, equals("ABNA 6775 6130 67"));
    });

    test('paste an IBAN with spaces', () {
      TextEditingValue oldValue = generate("", 0);
      TextEditingValue newValue = generate("NL 09 ABNA 6775 6130 67", 2);

      TextEditingValue reformatted = IbanPasteInputFormatter.countryCode(
        checkDigits,
        basicBankAccountNumber,
      ).formatEditUpdate(
        oldValue,
        newValue,
      );

      expect(reformatted.text, equals("NL"));
      expect(reformatted.selection.baseOffset, equals(2));
      expect(checkDigits.text, equals("09"));
      expect(basicBankAccountNumber.text, equals("ABNA 6775 6130 67"));
    });

    test('ignore previous input', () {
      TextEditingValue oldValue = generate("CH", 0);
      TextEditingValue newValue = generate("CHNL09ABNA6775613067", 2);

      TextEditingValue reformatted = IbanPasteInputFormatter.countryCode(
        checkDigits,
        basicBankAccountNumber,
      ).formatEditUpdate(
        oldValue,
        newValue,
      );

      expect(reformatted.text, equals("NL"));
      expect(reformatted.selection.baseOffset, equals(2));
      expect(checkDigits.text, equals("09"));
      expect(basicBankAccountNumber.text, equals("ABNA 6775 6130 67"));
    });

    test('paste a too long non IBAN string', () {});

    test('paste a short non IBAN string (noop)', () {
      TextEditingValue oldValue = generate("NL", 0);
      TextEditingValue newValue = generate("69", 2);

      TextEditingValue reformatted = IbanPasteInputFormatter.countryCode(
        checkDigits,
        basicBankAccountNumber,
      ).formatEditUpdate(
        oldValue,
        newValue,
      );

      expect(reformatted.text, equals("69"));
      expect(reformatted.selection.baseOffset, equals(2));
    });
	});
}

TextEditingValue generate(String text, int position) {
  return TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: position),
  );
}
