import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.inputType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? controller;
  final TextInputType inputType;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      controller: controller,
      style: const TextStyle(fontFamily: 'Roboto'),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xbbffffff),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.theme.primaryColor.withOpacity(0.5), width: 2),
          ),
          border: const OutlineInputBorder(),
          hintText: hintText,
          labelText: hintText,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          fillColor: const Color(0x77ffffff)),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
