import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/color_constants.dart';

class InputField extends StatelessWidget {
  final String label;
  final Icon icon;
  final TextInputType inputType;
  final String errorValue;
  final Function(String) onChanged;
  final length;
  final readOnly;
  final initialValue;

  const InputField({
    Key? key,
    this.label = "",
    required this.icon,
    this.inputType = TextInputType.text,
    required this.onChanged,
    required this.errorValue,
    this.readOnly = false,
    this.length,
    this.initialValue = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fontSize = MediaQuery.of(context).textScaleFactor;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: .5,
          color: readOnly == true
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.primary,
        ),
        borderRadius: BorderRadius.circular(15),
        // color: Theme.of(context).colorScheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: TextFormField(
          readOnly: readOnly,
          inputFormatters: [LengthLimitingTextInputFormatter(length)],
          onChanged: onChanged, // Pass the onChanged function here
          keyboardType: inputType,
          initialValue: initialValue,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),

          decoration: InputDecoration(
            prefixIconColor: Theme.of(context).colorScheme.primary,
            border: InputBorder.none,
            labelText: label.tr,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
            labelStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            suffixIconColor: Theme.of(context).colorScheme.primary,
            prefixIcon: icon,
            contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            iconColor: Theme.of(context).colorScheme.primary,
            errorText: errorValue == "" ? null : errorValue,
            errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: fontSize * 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onError,
                ),
          ),
        ),
      ),
    );
  }
}
