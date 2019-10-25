# A Flutter widget for capturing IBANs.

[![pub package](https://img.shields.io/pub/v/iban_form_field.svg)](https://pub.dartlang.org/packages/iban_form_field)
[![CircleCI](https://circleci.com/gh/inapay/iban_form_field.svg?style=svg)](https://circleci.com/gh/inapay/iban_form_field)

It features several features:
- Paste detection of IBANs
- Automatic field advancement
- Country specific hints

## Usage

See the [`example`](example/) directory.

## Integration testing

For your integrations tests the `TextFormField`s have distinct keys:
- 'iban-form-field-country-code'
- 'iban-form-field-check-digits'
- 'iban-form-field-basic-bank-account-number'
 
## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/inapay/iban_form_field/issues
