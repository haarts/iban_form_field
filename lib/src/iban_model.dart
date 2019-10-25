import 'package:iban/iban.dart' as iban;

class Iban {
  String countryCode;
  String checkDigits;
  String basicBankAccountNumber;

  Iban(this.countryCode);

  get countryCodeHintText => _example.substring(0, 2);
  get checkDigitsHintText => _example.substring(2, 4);

  get basicBankAccountNumberHintText {
    var every4Chars = RegExp(r'(.{4})(?!$)');
    return _example
        .substring(4, _example.length)
        .replaceAllMapped(every4Chars, (match) => '${match.group(0)} ');
  }

  get maxBasicBankAccountNumberLength => basicBankAccountNumberHintText.length;

  get electronicFormat => iban.electronicFormat(_concat);

  get toPrintFormat => iban.toPrintFormat(_concat);

  get isValid => iban.isValid(electronicFormat);

  get _concat => '$countryCode$checkDigits$basicBankAccountNumber';

  get _example {
    var particularSpecification = iban.specifications['CH'];
    if (iban.specifications.containsKey(countryCode)) {
      particularSpecification = iban.specifications[countryCode];
    }
    return particularSpecification.example;
  }

  String toString() =>
      "IBAN($countryCode $checkDigits $basicBankAccountNumber)";
}
