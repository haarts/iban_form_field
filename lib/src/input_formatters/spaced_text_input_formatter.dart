import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
