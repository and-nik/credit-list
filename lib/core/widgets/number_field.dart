import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class NumberField extends StatelessWidget {

  final TextEditingController controller;
  final String suffixText;
  final String placeholderText;
  final bool formatInput;
  final bool enableKeyboardDecimal;
  final Color? focusedBorderColor;
  final Color? borderColor;
  final Function(String value)? onChanged;

  const NumberField({
    super.key,
    required this.controller,
    required this.suffixText,
    required this.placeholderText,
    this.formatInput = false,
    this.enableKeyboardDecimal = false,
    this.focusedBorderColor,
    this.borderColor,
    this.onChanged,
  });

  static const double _coloredBorderWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.next,
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: enableKeyboardDecimal),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        if (formatInput)
          ThousandsFormatter(),
      ],
      decoration: InputDecoration(
        labelText: placeholderText,
        border: const OutlineInputBorder(),
        enabledBorder: borderColor == null
            ? null
            : OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor!,
            width: _coloredBorderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor ?? Theme.of(context).colorScheme.primary,
            width: _coloredBorderWidth,
          ),
        ),
        suffixText: suffixText,
      ),
      onChanged: onChanged,
    );
  }

}
