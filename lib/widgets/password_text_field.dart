import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/screen_utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    required this.hint,
    this.icon,
    this.controller,
  });
  final String hint;
  final Widget? icon;
  final TextEditingController? controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
          borderSide: BorderSide(
            color: kGreyShade3,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            getProportionateScreenWidth(8),
          ),
          borderSide: BorderSide(
            color: kGreyShade3,
          ),
        ),
        hintText: widget.hint,
        hintStyle: Theme.of(context).textTheme.headline4?.copyWith(
          color: kGreyShade3,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: kGreyShade3,
          ),
        ),
      ),
    );
  }
}
