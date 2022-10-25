import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final IconData fieldIcon;
  final bool fieldDataObscure;
  final TextEditingController? fieldControllerText;

  const CustomTextField({Key? key, required this.fieldIcon, this.fieldControllerText, this.fieldDataObscure = false}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: fieldControllerText,
      obscureText: fieldDataObscure,
      cursorColor: Color.fromRGBO(75, 68, 83, 1),
      decoration: InputDecoration(
        focusColor: Color.fromRGBO(75, 68, 83, 1),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(75, 68, 83, 1)
          ),
          borderRadius: BorderRadius.circular(7)
        ),
        label: Icon(
          fieldIcon,
          color: Color.fromRGBO(75, 68, 83, 1),
        ),
        constraints: BoxConstraints(maxHeight: 50, maxWidth: 520),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromRGBO(75, 68, 83, 1)
          ),
          borderRadius: BorderRadius.circular(7)
        )
      ),
    );
  }

}