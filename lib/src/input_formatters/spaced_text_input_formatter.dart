import 'package:flutter/services.dart';

class SpacedTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue _oldValue,
    TextEditingValue newValue,
  ) {
    // Find the position in the string with spaces removed
    var oldOffset = newValue.selection.baseOffset -
        RegExp(' ')
            .allMatches(newValue.text)
            .map((e) => e.start < newValue.selection.baseOffset)
            .fold(0, (x, y) => x + (y ? 1 : 0));
    var splitText = _splitInGroupsOfFour(newValue.text);
    // Find the new position by considering spaces inserted on the left
    var newOffset = oldOffset;
    for (var i = 0; i < newOffset; i += 1) {
      if (splitText[i] == ' ') {
        newOffset += 1;
      }
    }

    return TextEditingValue(
      text: splitText,
      selection: TextSelection.collapsed(
        offset: newOffset as int,
      ),
    );
  }

  String _splitInGroupsOfFour(String input) {
    input = input.replaceAll(RegExp(' '), '');
    var segments = input.split('');
    var groupSize = 4;
    var added = 0;
    var it = segments.iterator;
    final buffer = StringBuffer();
    while (it.moveNext()) {
      if (added != 0 && added % groupSize == 0) {
        buffer.write(' ');
      }
      added++;
      buffer.write(it.current);
    }
    return buffer.toString();
  }
}
