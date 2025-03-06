import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // Default hanya untuk password field
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
