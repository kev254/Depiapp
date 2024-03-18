import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onSelect;

  const CustomRadioButton({
    required this.label,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio(
          value: isSelected,
          groupValue: true,
          onChanged: (value) => onSelect(),
        ),
        Text(label),
      ],
    );
  }
}

