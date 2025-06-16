import 'package:flutter/services.dart';

class PostalCodeInputFormatterHelper extends TextInputFormatter {
  final maxLength = 8;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newValueLength = newValue.text.length;
    final newText = StringBuffer();

    var selectionIndex = newValue.selection.end;
    var substrInitial = 0;
    var substrIndex = 0;

    if (newValueLength > maxLength) {
      return oldValue;
    }    

    if (newValueLength >= 6) {
      newText.write('${newValue.text.substring(substrInitial, substrIndex = 5)}-');
      if (newValue.selection.end >= 5) selectionIndex++;
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(
        offset: selectionIndex,
      ),
    );
  }
}
