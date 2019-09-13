import 'package:iban/iban.dart' as iban;

class Iban {
  String countryCode;
  String checkDigits;
  String basicBankAccountNumber;

  Iban(this.countryCode);

  get hintText {
    var particularSpecification = iban.specifications['CH'];
    if (iban.specifications.containsKey(countryCode)) {
      particularSpecification = iban.specifications[countryCode];
    }

    var every4Chars = RegExp(r'(.{4})(?!$)');
    return particularSpecification.example
        .substring(4, particularSpecification.example.length)
        .replaceAllMapped(every4Chars, (match) => '${match.group(0)} ');
  }

  get maxBasicBankAccountNumberLength => hintText.length;

  get electronicFormat => iban.electronicFormat(_concat);

  get toPrintFormat => iban.toPrintFormat(_concat);

  get isValid => iban.isValid(electronicFormat);

  get _concat => '$countryCode$checkDigits$basicBankAccountNumber';

  String toString() =>
      "IBAN($countryCode $checkDigits $basicBankAccountNumber)";
}
