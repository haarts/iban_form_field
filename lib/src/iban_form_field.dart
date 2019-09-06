import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iban_form_field/src/iban_model.dart';

class IbanFormField extends FormField<Iban> {
  IbanFormField({
    FormFieldSetter<Iban> onSaved,
    FormFieldValidator<Iban> validator,
    Iban initialValue,
    bool autovalidate = false,
  }) : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<Iban> state) {
              return Row(
                children: [
                  Container(
                    constraints: BoxConstraints.tightFor(
                      width: Theme.of(state.context).textTheme.body1.fontSize *
                          1.1 *
                          2,
                    ),
                    padding: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      initialValue: initialValue.countryCode,
                      maxLength: 2,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[A-Z]")),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints.tightFor(
                      width: Theme.of(state.context).textTheme.body1.fontSize *
                          1.1 *
                          2,
                    ),
                    padding: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      initialValue: initialValue.checkDigits,
                      maxLength: 2,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[0-9]")),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      initialValue: initialValue.basicBankAccountNumber,
                      maxLength: initialValue.maxBasicBankAccountNumberLength,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        SpacedTextInputFormatter(),
                      ]
                    ),
                  ),
                ],
              );
            });
}

class IbanCountryCode extends FormField<String> {}

class SpacedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String splitText = _splitInGroupsOfFour(newValue.text);
    int numberOfSpacesAdded = splitText.length - newValue.text.length;

    return TextEditingValue(
      text: splitText,
      selection: TextSelection.collapsed(
        offset: newValue.selection.baseOffset + numberOfSpacesAdded,
      ),
    );
  }

  String _splitInGroupsOfFour(String input) {
    input = input.replaceAll(RegExp(" "), "");
    List<String> segments = input.split('');
    int groupSize = 4;
    var added = 0;
    String result = '';
    var it = segments.iterator;
    while(it.moveNext()) {
      if (added != 0 && added % groupSize == 0) {
        result += ' ';
      }
      added++;
      result += it.current;
    }
    return result;
  }
}

