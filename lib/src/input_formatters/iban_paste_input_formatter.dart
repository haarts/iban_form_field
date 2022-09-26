import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iban/iban.dart' as iban;

class IbanPasteInputFormatter extends TextInputFormatter {
  IbanPasteInputFormatter.countryCode(
    this.checkDigitsController,
    this.basicBankAccountNumberController,
  ) : toBeReturnedPart = countryCodeRegExp;

  IbanPasteInputFormatter.checkDigits(
    this.countryCodeController,
    this.basicBankAccountNumberController,
  ) : toBeReturnedPart = checkDigitsRegExp;

  IbanPasteInputFormatter.basicBankAccountNumber(
    this.countryCodeController,
    this.checkDigitsController,
  ) : toBeReturnedPart = basicBankAccountNumberRegExp;

  TextEditingController? countryCodeController;
  TextEditingController? checkDigitsController;
  TextEditingController? basicBankAccountNumberController;

  final RegExp toBeReturnedPart;

  static RegExp countryCodeRegExp = RegExp(r'^([A-Z]{2})');
  static RegExp checkDigitsRegExp = RegExp(r'^[A-Z]{2}([0-9]{2})');
  static RegExp basicBankAccountNumberRegExp = RegExp(r'^.{4}(.+$)');

  @override
  TextEditingValue formatEditUpdate(oldValue, newValue) {
    var possibleIban = newValue.text.replaceAll(' ', '');
    var matchedSpecification = iban.specifications.values.firstWhereOrNull(
      (specification) => RegExp(_withoutAnchors(specification.regexDef))
          .hasMatch(possibleIban),
    );

    if (matchedSpecification == null) {
      return newValue;
    }

    var flatIban = RegExp(_withoutAnchors(matchedSpecification.regexDef))
        .firstMatch(possibleIban)!
        .group(0)!;

    _filloutOtherControllers(flatIban);

    var newText = _inGroupsOf4(toBeReturnedPart.firstMatch(flatIban)!.group(1)!);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: newText.length,
      ),
    );
  }

  void _filloutOtherControllers(String flatIban) {
    if (toBeReturnedPart == countryCodeRegExp) {
      checkDigitsController!.text =
          checkDigitsRegExp.firstMatch(flatIban)!.group(1)!;
      basicBankAccountNumberController!.text = _inGroupsOf4(
          basicBankAccountNumberRegExp.firstMatch(flatIban)!.group(1)!);
    } else if (toBeReturnedPart == checkDigitsRegExp) {
      countryCodeController!.text =
          countryCodeRegExp.firstMatch(flatIban)!.group(1)!;
      basicBankAccountNumberController!.text = _inGroupsOf4(
          basicBankAccountNumberRegExp.firstMatch(flatIban)!.group(1)!);
    } else {
      countryCodeController!.text =
          countryCodeRegExp.firstMatch(flatIban)!.group(1)!;
      checkDigitsController!.text =
          checkDigitsRegExp.firstMatch(flatIban)!.group(1)!;
    }
  }

  String _inGroupsOf4(String s) {
    var every4Chars = RegExp(r'(.{4})(?!$)');
    return s.replaceAllMapped(every4Chars, (match) => '${match[0]} ');
  }

  String _withoutAnchors(String regex) {
    return regex.substring(1, regex.length - 1);
  }
}
