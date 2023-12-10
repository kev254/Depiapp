import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String hint;
  final List<String> options;
  final String? selectedValue;
  final void Function(String?) onChanged;

  const CustomDropdown({
    required this.hint,
    required this.options,
    required this.onChanged,
    this.selectedValue,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey),
        ),
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
          color: Colors.grey,
        ),
      ),
      value: widget.selectedValue,
      onChanged: widget.onChanged,
      items: widget.options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
    );
  }
}
