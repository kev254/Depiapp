import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelect;
  final TextEditingController controller;

  const CustomRadioButton({
    required this.label,
    required this.isSelected,
    required this.onSelect,
    required this.controller,
  });

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onSelect(!widget.isSelected);
        widget.controller.text = widget.isSelected ? 'Selected' : 'Not Selected';
      },
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: widget.isSelected ? Colors.blue : Colors.grey,
              ),
            ),
            child: Center(
              child: widget.isSelected
                  ? Icon(
                Icons.check,
                size: 16,
                color: Colors.blue,
              )
                  : null,
            ),
          ),
          SizedBox(width: 8),
          Text(widget.label),
        ],
      ),
    );
  }
}
