import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:iban_form_field/src/iban_model.dart';
import 'package:iban_form_field/src/input_formatters/iban_paste_input_formatter.dart';
import 'package:iban_form_field/src/input_formatters/spaced_text_input_formatter.dart';

class IbanFormField extends FormField<Iban> {
  IbanFormField({
    Key key,
    FormFieldSetter<Iban> onSaved,
    FormFieldValidator<Iban> validator,
    Iban initialValue,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue ?? Iban('CH'),
          builder: (FormFieldState<Iban> state) {
            return IbanFormFieldBuilder(state);
          },
        );
}

class IbanFormFieldBuilder extends StatefulWidget {
  final FormFieldState<Iban> state;
  IbanFormFieldBuilder(this.state);

  @override
  State createState() => _IbanFormFieldState();
}

class _IbanFormFieldState extends State<IbanFormFieldBuilder> {
  static const _maxCountryCodeLength = 2;
  static const _maxCheckDigitLength = 2;

  final TextEditingController _controllerCountryCode = TextEditingController();
  final TextEditingController _controllerCheckDigits = TextEditingController();
  final TextEditingController _controllerBasicBankAccountNumber =
      TextEditingController();

  // Used for jumping to next/previous field
  final FocusNode _focusCountryCode = FocusNode();
  final FocusNode _focusCheckDigits =
      FocusNode(debugLabel: 'check-digits-focus-node');
  final FocusNode _focusBasicBankAccountNumber = FocusNode();

  // Used to determine if the user added or deleted characters
  int _previousCountryCodeLength;
  int _previousCheckDigitsLength;
  int _previousBasicBankAccountNumberLength;

  bool _lastCountryCodeCharacterAdded(int currentLength, int previousLength) {
    return currentLength == _maxCountryCodeLength &&
        currentLength - previousLength == 1;
  }

  bool _lastCheckDigitCharacterAdded(int currentLength, int previousLength) {
    return currentLength == _maxCheckDigitLength &&
        currentLength - previousLength == 1;
  }

  bool _lastCheckDigitCharacterDeleted(int currentLength, int previousLength) {
    return currentLength == 0 && currentLength - previousLength == -1;
  }

  bool _lastBasicBankAccountNumberCharacterDeleted(
      int currentLength, int previousLength) {
    return currentLength == 0 && currentLength - previousLength == -1;
  }

  @override
  void initState() {
    super.initState();

    _controllerCountryCode.text = widget.state.value.countryCode;
    _controllerCheckDigits.text = widget.state.value.checkDigits;
    _controllerBasicBankAccountNumber.text =
        widget.state.value.basicBankAccountNumber;

    _previousCountryCodeLength = widget.state.value.countryCode?.length ?? 0;
    _previousCheckDigitsLength = widget.state.value.checkDigits?.length ?? 0;
    _previousBasicBankAccountNumberLength =
        widget.state.value.basicBankAccountNumber?.length ?? 0;

    _controllerCountryCode.addListener(() {
      if (_lastCountryCodeCharacterAdded(
          _controllerCountryCode.text.length, _previousCountryCodeLength)) {
        setState(() {
          widget.state.value.countryCode = _controllerCountryCode.text;
        });
        _focusCountryCode.nextFocus();
      }

      _previousCountryCodeLength = _controllerCountryCode.text.length;
    });

    _controllerCheckDigits.addListener(() {
      if (_lastCheckDigitCharacterDeleted(
          _controllerCheckDigits.text.length, _previousCheckDigitsLength)) {
        _focusCheckDigits.previousFocus();
      }

      if (_lastCheckDigitCharacterAdded(
          _controllerCheckDigits.text.length, _previousCheckDigitsLength)) {
        _focusCheckDigits.nextFocus();
      }

      _previousCheckDigitsLength = _controllerCheckDigits.text.length;
    });

    _controllerBasicBankAccountNumber.addListener(() {
      if (_lastBasicBankAccountNumberCharacterDeleted(
          _controllerBasicBankAccountNumber.text.length,
          _previousBasicBankAccountNumberLength)) {
        _focusBasicBankAccountNumber.previousFocus();
      }

      _previousBasicBankAccountNumberLength =
          _controllerBasicBankAccountNumber.text.length;
    });
  }

  @override
  void dispose() {
    _controllerCountryCode.dispose();
    _controllerCheckDigits.dispose();
    _controllerBasicBankAccountNumber.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: BoxConstraints.tightFor(
            width: Theme.of(widget.state.context).textTheme.body1.fontSize *
                1.1 *
                2,
          ),
          padding: EdgeInsets.only(right: 5),
          child: TextFormField(
            key: Key('country-code'),
            controller: _controllerCountryCode,
            focusNode: _focusCountryCode,
            decoration: const InputDecoration(
              hintText: 'CH',
            ),
            textInputAction: TextInputAction.next,
            onSaved: (countryCode) {
              widget.state.value.countryCode = countryCode;
            },
            maxLength: 2,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              IbanPasteInputFormatter.countryCode(
                _controllerCheckDigits,
                _controllerBasicBankAccountNumber,
              ),
              WhitelistingTextInputFormatter(RegExp("[A-Z]")),
            ],
          ),
        ),
        Container(
          constraints: BoxConstraints.tightFor(
            width: Theme.of(widget.state.context).textTheme.body1.fontSize *
                1.1 *
                2,
          ),
          padding: EdgeInsets.only(right: 5),
          child: TextFormField(
            controller: _controllerCheckDigits,
            focusNode: _focusCheckDigits,
            decoration: const InputDecoration(
              hintText: '12',
            ),
            textInputAction: TextInputAction.next,
            onSaved: (checkDigits) {
              widget.state.value.checkDigits = checkDigits;
            },
            maxLength: 2,
            keyboardType: TextInputType.numberWithOptions(),
            inputFormatters: [
              IbanPasteInputFormatter.checkDigits(
                _controllerCountryCode,
                _controllerBasicBankAccountNumber,
              ),
              WhitelistingTextInputFormatter(RegExp("[0-9]")),
            ],
          ),
        ),
        Flexible(
          child: TextFormField(
            controller: _controllerBasicBankAccountNumber,
            focusNode: _focusBasicBankAccountNumber,
            decoration: InputDecoration(
              hintText: widget.state.value.hintText,
            ),
            onSaved: (basicBankAccountNumber) {
              widget.state.value.basicBankAccountNumber =
                  basicBankAccountNumber;
            },
            maxLength: widget.state.value.maxBasicBankAccountNumberLength,
            textCapitalization: TextCapitalization.characters,
            inputFormatters: [
              IbanPasteInputFormatter.basicBankAccountNumber(
                _controllerCountryCode,
                _controllerCheckDigits,
              ),
              SpacedTextInputFormatter(),
            ],
          ),
        ),
      ],
    );
  }
}