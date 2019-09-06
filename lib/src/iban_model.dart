class Iban {
  final String countryCode;
  String checkDigits;
  String basicBankAccountNumber;

  /// Mapping between country and the maximum length of the basic bank account number.
  /// Source: https://bfsfcu.org/pdf/IBAN.pdf
  static Map<String, int> _maxLengths = {
    "NL": 18,
    "CH": 21,
  };

  Iban(this.countryCode);

  get maxBasicBankAccountNumberLength => _maxLengths[countryCode];

  String toString() =>
      "IBAN($countryCode $checkDigits $basicBankAccountNumber)";
}
