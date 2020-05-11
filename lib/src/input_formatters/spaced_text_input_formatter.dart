import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpacedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var splitText = _splitInGroupsOfFour(newValue.text);
    var numberOfSpacesAdded = splitText.length - newValue.text.length;

    return TextEditingValue(
      text: splitText,
      selection: TextSelection.collapsed(
        offset: newValue.selection.baseOffset + numberOfSpacesAdded,
      ),
    );
  }

  String _splitInGroupsOfFour(String input) {
    input = input.replaceAll(RegExp(' '), '');
    var segments = input.split('');
    var groupSize = 4;
    var added = 0;
    var result = '';
    var it = segments.iterator;
    while (it.moveNext()) {
      if (added != 0 && added % groupSize == 0) {
        result += ' ';
      }
      added++;
      result += it.current;
    }
    return result;
  }
}
