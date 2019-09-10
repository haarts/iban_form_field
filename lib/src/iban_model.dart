import 'package:iban/iban.dart' as iban;

class Iban {
  String countryCode;
  String checkDigits;
  String basicBankAccountNumber;

  Iban(this.countryCode);

  String get hintText {
    var every4Chars = new RegExp(r'(.{4})(?!$)');
    return iban.specifications[countryCode].example
        .substring(4, iban.specifications[countryCode].example.length)
        .replaceAllMapped(every4Chars, (match) => '${match.group(0)} ');
  }

  get maxBasicBankAccountNumberLength => hintText.length;

  String toString() =>
      "IBAN($countryCode $checkDigits $basicBankAccountNumber)";
}
